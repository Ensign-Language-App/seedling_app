import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Center(child: LessonButton(
  image: 'assets/icons/flags/US_flag.png',
  number: '1',
  title: 'Lesson 1',
  color: Colors.red,
)))));

class LessonButton extends StatefulWidget {
  final String image;
  final String number;
  final String title;
  final Color color;

  const LessonButton({super.key, required this.image, required this.number, required this.title, required this.color});

  @override
  LessonButtonState createState() => LessonButtonState();
}

class LessonButtonState extends State<LessonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                value: 0.2,
                strokeWidth: 50,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF0E1415) : const Color(0xFFF5FAFB),
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(widget.image),
              ),
            ],
          ),
          Text(widget.title, style: const TextStyle(fontSize: 20)),
          Text(widget.number, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}