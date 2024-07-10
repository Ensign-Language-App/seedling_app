import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seedling_app/widgets/language_selector.dart'; 
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: LessonPage(selectedLanguage: 'English'),
  ));
}

// ignore: must_be_immutable
class LessonPage extends StatefulWidget {
  String selectedLanguage;
  LessonPage({super.key, required this.selectedLanguage});
  
  @override
  LessonPageState createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isCardVisible = true;
  List<Map<String, String>> words = [];
  int currentIndex = 0;
  bool isLoading = true;
  String message = '';
  // String selectedLanguage = 'Spanish';

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  // void onLanguageChanged(String language) {
  //   setState(() {
  //     selectedLanguage = language;
  //     isLoading = true;
  //   });
  //   fetchWords();
  // }

  Future<void> fetchWords() async {
    const maxRetries = 5;
    const backoffDuration = Duration(seconds: 2);
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        print('Attempting to fetch words...');
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Vocabulary')
            .doc('Subjects')
            .collection('People')
            .get();

  List<Map<String, String>> fetchedWords = [];
        for (var doc in querySnapshot.docs) {
          print('Fetched document: ${doc.id} with data: ${doc.data()}');
          fetchedWords.add({
            'english': doc.id,
            widget.selectedLanguage.toLowerCase(): doc[widget.selectedLanguage],
          });
        }

        setState(() {
          words = fetchedWords;
          isLoading = false;
        });

        print('Fetched words: $words');
        return;
      } catch (e) {
        print('Error fetching words: $e');
        retryCount++;
        if (retryCount < maxRetries) {
          await Future.delayed(backoffDuration * retryCount);
        } else {
          setState(() {
            message = 'Error fetching words: $e';
            isLoading = false;
          });
          return;
        }
      }
    }
  }

  void resetCard() {
    setState(() {
      isCardVisible = true;
    });
  }

  void showNextCard() {
    setState(() {
      currentIndex = (currentIndex + 3) % words.length;
      isCardVisible = true;
    });
  }

  void showPreviousCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % words.length;
      isCardVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),
      appBar: AppBar(title: const Text('Learn')),
      body: Column(
        children: [
          LanguageSelector(
            width: 50,
            height: 50,
            onLanguageChanged: (String language) {
              setState(() {
                widget.selectedLanguage = language;
                isLoading = true;
              });
              fetchWords();
            },
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : words.isEmpty
                    ? Center(child: Text(message.isEmpty ? 'No words found' : message))
                    : Center(
                        child: isCardVisible
                            ? GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                },
                                child: Dismissible(
                                  key: Key(words[currentIndex]['english']!),
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    if (direction == DismissDirection.endToStart) {
                                      // Left Swipe
                                      setState(() {
                                        isCardVisible = false;
                                      });
                                      // Show the next card after a delay
                                      Future.delayed(const Duration(milliseconds: 300), showNextCard);
                                    } else {
                                      // Right Swipe
                                      setState(() {
                                        isCardVisible = false;
                                      });
                                      // Show the next card after a delay
                                      Future.delayed(const Duration(milliseconds: 300), showPreviousCard);
                                    }

                                    setState(() {
                                      isCardVisible = false;
                                    });
                                    // Show the next card after a delay
                                    Future.delayed(const Duration(milliseconds: 300), showNextCard);
                                  },
                                  child: Dismissible(
                                    key: Key('flip_card_$currentIndex'),
                                    direction: DismissDirection.vertical,
                                    onDismissed: (direction) {
                                      setState(() {
                                        isCardVisible = false;
                                      });
                                      // Reset the card after a delay
                                      Future.delayed(const Duration(milliseconds: 300), resetCard);
                                    },
                                    child: FlipCard(
                                      key: cardKey,
                                      direction: FlipDirection.HORIZONTAL,
                                      front: Card(
                                        elevation: 8.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          height: 450,
                                          width: 300,
                                          alignment: Alignment.center,
                                          child: Text(
                                            words[currentIndex]['english']!,
                                            style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      back: Card(
                                        elevation: 8.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          height: 450,
                                          width: 300,
                                          alignment: Alignment.center,
                                          child: Text(
                                            words[currentIndex][widget.selectedLanguage.toLowerCase()]!,
                                            style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
          ),
        ],
      ),
    );
  }
}

