import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/lesson_page.dart'; // Import the LessonPage
import '../providers/progress_provider.dart'; // Import the provider

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: LessonButton(
        image: 'assets/icons/flags/US_flag.png',
        title: 'Lesson 1',
        lessonColor: Color(0xFFf4a261),
        stackColor1: Color(0xFFe9c46a),
        stackColor2: Color(0xFF2a9d8f),
        nativeLanguage: 'English',
        learningLanguage: 'French',
        topic: 'Greetings',
      ),
    ),
  ),
));

class LessonButton extends StatefulWidget {
  final String image;
  final String title;
  final Color lessonColor;
  final Color stackColor1;
  final Color stackColor2;
  final String nativeLanguage;
  final String learningLanguage;
  final String topic;

  const LessonButton({
    super.key,
    required this.image,
    required this.title,
    required this.lessonColor,
    required this.stackColor1,
    required this.stackColor2,
    required this.nativeLanguage,
    required this.learningLanguage,
    required this.topic,
  });

  @override
  LessonButtonState createState() => LessonButtonState();
}

class ColoredCard extends StatelessWidget {
  final Offset offset;
  final Color color;
  final double rotation;

  const ColoredCard({
    super.key,
    required this.offset,
    required this.color,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          width: 130,
          height: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonButtonState extends State<LessonButton> {
  @override
  Widget build(BuildContext context) {
    double progress = Provider.of<ProgressProvider>(context).getProgress(widget.topic);

    return Stack(alignment: Alignment.center, children: <Widget>[
      ColoredCard(
        offset: const Offset(10, 10),
        color: widget.stackColor1,
        rotation: 0.1,
      ),
      ColoredCard(
        offset: const Offset(-20, -20),
        color: widget.stackColor2,
        rotation: -0.1,
      ),
      GestureDetector(
        child: Container(
          width: 140,
          height: 130,
          decoration: BoxDecoration(
            color: widget.lessonColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      widget.image,
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(fontSize: widget.title.length > 15 ? 7 : 11),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey[500],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              value: progress,
                              strokeWidth: 2,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPage(
                nativeLanguage: widget.nativeLanguage,
                learningLanguage: widget.learningLanguage,
                topic: widget.topic,
              ),
            ),
          );
        },
      )
    ]);
  }
}
