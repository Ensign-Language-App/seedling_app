import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import 'lesson_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProgressProvider(),
      child: const MaterialApp(
        home: BookmarkPage(),
      ),
    );
  }
}

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  final List<String> topics = [
    'Animals', 'Greetings', 'Family', 'Body', 'Numbers', 'Food & Drink',
    'Clothing', 'Places', 'The Body', 'Traffics', 'People', 'Home', 'Dining',
    'Travel', 'Directions', 'Health', 'Emergency', 'Shopping', 'Money', 'Colors',
    'Days', 'Months', 'Time', 'Questions', 'Conversation', 'Adjectives', 'Verbs',
    'Regular Verbs', 'Irregular Verbs', 'Subject Pronouns', 'Possessive Pronouns',
    'Prepositions', 'Conjunctions'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgressProvider>(context, listen: false).loadProgressFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: topics.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(
              height: 20.0,
            );
          }
          String topic = topics[index - 1];
          double progress = Provider.of<ProgressProvider>(context).getProgress('French', topic);
          return ListTile(
            title: Text(topic),
            trailing: Text('${(progress * 100).toStringAsFixed(1)}%'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonPage(
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: topic,
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}