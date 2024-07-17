import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ProgressProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;
  final List<String> subjects = [
    'Adjectives'
    'Animals',
    'Articles'
    'Body',
    'Colors',
    'Conjunctions',
    'Conversation',
    'Days',
    'Dinning',
    'Directions',
    'Emergency',
    'Family',
    'Food & Drink',
    'Greetings',
    'Health',
    'Home',
    'Irregular Verbs',
    'Money',
    'Months',
    'Numbers',
    'People',
    'Places',
    'Positive Pronouns',
    'Prepositions',
    'Regular Verbs',
    'Shopping',
    'Subject Pronouns',
    'Time',
    'Travel',
    'Verbs'
  ];

  Map<String, double> _progress = {};
  Map<String, List<String>> _masteredCards = {};

  double getProgress(String topic, String learningLanguage) {
    return _progress['$topic-$learningLanguage'] ?? 0.0;
  }

  List<String> getMasteredCards(String topic, String learningLanguage) {
    return _masteredCards['$topic-$learningLanguage'] ?? [];
  }

  void setProgress(String topic, String learningLanguage, double progress) {
    _progress['$topic-$learningLanguage'] = progress;
    saveProgressToFirestore();
    notifyListeners();
  }

  void addMasteredCard(String topic, String learningLanguage, String card) {
    if (_masteredCards.containsKey('$topic-$learningLanguage')) {
      _masteredCards['$topic-$learningLanguage']!.add(card);
    } else {
      _masteredCards['$topic-$learningLanguage'] = [card];
    }
    saveProgressToFirestore();
    notifyListeners();
  }

  Future<void> saveProgressToFirestore() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      await _firestore.collection('user_progress').doc(_user!.uid).set({
        'progress': _progress,
        'masteredCards': _masteredCards,
      }, SetOptions(merge: true));
    }
  }

  Future<void> loadProgressFromFirestore() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentSnapshot doc = await _firestore.collection('user_progress').doc(_user!.uid).get();
      if (doc.exists) {
        try {
          Map<String, dynamic> progressData = doc.get('progress') ?? {};
          Map<String, double> progressMap = {};
          progressData.forEach((key, value) {
            if (value is double) {
              progressMap[key] = value;
            } else if (value is int) {
              progressMap[key] = value.toDouble();
            } else {
              debugPrint('Invalid progress value for $key: $value');
            }
          });
          _progress = progressMap;

          Map<String, dynamic> masteredCardsData = doc.get('masteredCards') ?? {};
          Map<String, List<String>> masteredCardsMap = {};
          masteredCardsData.forEach((key, value) {
            if (value is List<dynamic>) {
              masteredCardsMap[key] = List<String>.from(value);
            } else {
              debugPrint('Invalid mastered cards value for $key: $value');
            }
          });
          _masteredCards = masteredCardsMap;

        } catch (e) {
          debugPrint('Error parsing progress data: $e');
          _progress = {};
          _masteredCards = {};
        }
        notifyListeners();
      } else {
        _progress = {};
        _masteredCards = {};
      }
    }
  }

  int getTotalMasteredCards(String learningLanguage) {
    int totalMasteredCards = 0;
    _masteredCards.forEach((key, value) {
      if (key.contains(learningLanguage)) {
        totalMasteredCards += value.length;
      }
    });
    return totalMasteredCards;
  }

  Future<int> getTotalCards() async {
    int totalCards = 0;
    try {
      debugPrint('Attempting to fetch words...');
      for(String subject in subjects) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Vocabulary')
            .doc('Subjects')
            .collection(subject)
            .get();
        totalCards += querySnapshot.docs.length;
      }

      debugPrint('Fetched total cards: $totalCards');
    } catch (e) {
      debugPrint('Error fetching total cards: $e');
    }
    return totalCards;
  }

  Future<double> getTotalProgress(context) async {
    int totalCards = await getTotalCards();
    if(totalCards == 0) {
      return 0.0;
    }
    return getTotalMasteredCards(getLearningLanguage(context)) / await getTotalCards();
  }

  String getLearningLanguage(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return languageProvider.learningLanguage;
  }

}
