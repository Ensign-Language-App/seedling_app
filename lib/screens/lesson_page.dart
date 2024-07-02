import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  const MaterialApp(
    home: LessonPage(),
  ),
);

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  LessonPageState createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isCardVisible = true;

  void resetCard() {
    setState(() {
      isCardVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0), // Using RGB values
      appBar: AppBar(title: const Text('Learn')),
      body: Center(
        child: isCardVisible
            ? GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                },
                child: Dismissible(
                  key: const Key('flip_card'),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      isCardVisible = false;
                    });
                    // Reset the card after a delay
                    Future.delayed(const Duration(milliseconds: 300), resetCard);
                  },
                  child: Dismissible(
                    key: const Key('flip_card_vertical'),
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
                          child: const Text(
                            'The best anime \never made is...',
                            style: TextStyle(
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
                          child: const Text(
                            'Saint Seiya',
                            style: TextStyle(
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
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';

// class LessonPage extends StatefulWidget {
//   const LessonPage({super.key});

//   @override
//   LessonPageState createState() => LessonPageState();
// }

// class LessonPageState extends State<LessonPage> {
//   bool isLoading = true;
//   String message = "Loading...";

//   @override
//   void initState() {
//     super.initState();
//     fetchSingleWordWithRetry();
//   }

//   Future<void> fetchSingleWordWithRetry() async {
//     const maxRetries = 5;
//     const backoffDuration = Duration(seconds: 2);
//     int retryCount = 0;

//     while (retryCount < maxRetries) {
//       try {
//         DocumentSnapshot doc = await FirebaseFirestore.instance
//             .collection('Subjects')
//             .doc('Test')
//             .collection('Words')
//             .doc('Dog')
//             .get();

//         if (doc.exists) {
//           print('Fetched document: ${doc.id} with data: ${doc.data()}');
//           setState(() {
//             message = 'Fetched document: ${doc.id} with data: ${doc.data()}';
//             isLoading = false;
//           });
//           return;
//         } else {
//           print('Document does not exist');
//           setState(() {
//             message = 'Document does not exist';
//             isLoading = false;
//           });
//           return;
//         }
//       } catch (e) {
//         print('Error fetching word: $e');
//         retryCount++;
//         if (retryCount < maxRetries) {
//           await Future.delayed(backoffDuration * retryCount);
//         } else {
//           setState(() {
//             message = 'Error fetching word: $e';
//             isLoading = false;
//           });
//           return;
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Firestore Test')),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : Text(message),
//       ),
//     );
//   }
// }









