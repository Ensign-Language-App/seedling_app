import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';

class LessonPage extends StatefulWidget {
  final String nativeLanguage;
  final String learningLanguage;
  final String topic;

  const LessonPage({
    super.key,
    required this.nativeLanguage,
    required this.learningLanguage,
    required this.topic,
  });

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
  int totalCards = 0;

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  Future<void> fetchWords() async {
    const maxRetries = 5;
    const backoffDuration = Duration(seconds: 2);
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        debugPrint('Attempting to fetch words...');
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Vocabulary')
            .doc('Subjects')
            .collection(widget.topic)
            .get();

        totalCards = querySnapshot.docs.length;

        List<Map<String, String>> fetchedWords = [];
        for (var doc in querySnapshot.docs) {
          debugPrint('Fetched document: ${doc.id} with data: ${doc.data()}');
          var data = doc.data() as Map<String, dynamic>;
          fetchedWords.add({
            'english': doc.id,
            'spanish': data['Spanish'] ?? 'N/A',
            'portuguese': data['Portuguese'] ?? 'N/A',
            'french': data['French'] ?? 'N/A',
            'italian': data['Italian'] ?? 'N/A',
            'german': data['German'] ?? 'N/A',
            'russian': data['Russian'] ?? 'N/A',
            'chinese (simplified)': data['Chinese (Simplified)'] ?? 'N/A',
            'chinese (traditional)': data['Chinese (Traditional)'] ?? 'N/A',
            'japanese': data['Japanese'] ?? 'N/A',
            'korean': data['Korean'] ?? 'N/A',
          });
        }

        setState(() {
          words = fetchedWords
              .where((word) => !Provider.of<ProgressProvider>(context, listen: false)
              .getMasteredCards(widget.topic, widget.learningLanguage)
              .contains(word['english']))
              .toList();
          isLoading = false;
        });

        debugPrint('Fetched words: $words');
        return;
      } catch (e) {
        debugPrint('Error fetching words: $e');
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
      currentIndex = (currentIndex + 1) % words.length;
      isCardVisible = true;
    });
  }

  void showPreviousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + words.length) % words.length;
      isCardVisible = true;
    });
  }

  void addToMaster(BuildContext context) {
    Provider.of<ProgressProvider>(context, listen: false).addMasteredCard(
      widget.topic,
      widget.learningLanguage,
      words[currentIndex]['english']!,
    );
  }

  void removeCardFromReviewList(BuildContext context) {
    setState(() {
      addToMaster(context);
      words.removeAt(currentIndex);
      if (currentIndex >= words.length) {
        currentIndex = 0;
      }
      isCardVisible = false;
      if (words.isEmpty) {
        message = 'Congratulations, you have completed all words in this section.';
        Provider.of<ProgressProvider>(context, listen: false).setProgress(
          widget.topic,
          widget.learningLanguage,
          1.0,
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 300), resetCard);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        Provider.of<ProgressProvider>(context, listen: false).setProgress(
          widget.topic,
          widget.learningLanguage,
          totalCards == 0
              ? 0
              : Provider.of<ProgressProvider>(context, listen: false)
              .getMasteredCards(widget.topic, widget.learningLanguage)
              .length /
              totalCards.toDouble(),
        );
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Provider.of<ProgressProvider>(context, listen: false).setProgress(
                widget.topic,
                widget.learningLanguage,
                Provider.of<ProgressProvider>(context, listen: false)
                    .getMasteredCards(widget.topic, widget.learningLanguage)
                    .length /
                    totalCards.toDouble(),
              );
              Navigator.pop(context);
            },
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : words.isEmpty
            ? Center(
            child: Text(message.isEmpty ? 'No words found' : message))
            : Center(
          child: isCardVisible
              ? GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
            },
            child: Dismissible(
              key: Key(words[currentIndex]['english']!),
              direction: DismissDirection.horizontal,
              background: const Text(
                "\n\nPrevious",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(175, 255, 255, 255),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              secondaryBackground: const Text(
                "\n\nNext",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(175, 255, 255, 255),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Left Swipe
                  setState(() {
                    isCardVisible = false;
                  });
                  // Show the next card after a delay
                  Future.delayed(
                      const Duration(milliseconds: 300),
                      showNextCard);
                } else {
                  // Right Swipe
                  setState(() {
                    isCardVisible = false;
                  });
                  // Show the previous card after a delay
                  Future.delayed(
                      const Duration(milliseconds: 300),
                      showPreviousCard);
                }
              },
              child: Dismissible(
                key: Key('flip_card_$currentIndex'),
                direction: DismissDirection.up,
                background: const Text(
                  "\n\n\nMastered",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(175, 255, 255, 255),
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                onDismissed: (direction) {
                  removeCardFromReviewList(context);
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
                        words[currentIndex][widget.nativeLanguage
                            .toLowerCase()] ??
                            'N/A',
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
                        words[currentIndex][widget.learningLanguage
                            .toLowerCase()] ??
                            'N/A',
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
    );
  }
}
