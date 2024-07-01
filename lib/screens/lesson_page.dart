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
// import 'package:flip_card/flip_card.dart';

// void main() => runApp(
//       const MaterialApp(
//         home: LessonPage(),
//       ),
//     );

// class LessonPage extends StatelessWidget {
//   const LessonPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),  // Using RGB values
//       // backgroundColor: Colors.lightGreen, // Using predefined color
//       appBar: AppBar(title: const Text('Learn')),
//       body: Center(
//         child: FlipCard(
//           direction: FlipDirection.HORIZONTAL,
//           front: Card(
//             elevation: 8.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Container(
//               height: 200,
//               width: 300,
//               alignment: Alignment.center,
//               child: const Text(
//                 'The best anime \never made is...',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           back: Card(
//             elevation: 8.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Container(
//               height: 200,
//               width: 300,
//               alignment: Alignment.center,
//               child: const Text(
//                 'Saint Seiya',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

