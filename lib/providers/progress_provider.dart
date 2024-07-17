import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

  Map<String, Map<String, double>> _progress = {};
  Map<String, Map<String, List<String>>> _masteredCards = {};

  double getProgress(String topic, String language) {
    return _progress[language]?[topic] ?? 0.0;
  }

  List<String> getMasteredCards(String topic, String language) {
    return _masteredCards[language]?[topic] ?? [];
  }

  void setProgress(String topic, String language, double progress) {
    _progress[language] ??= {};
    _progress[language]![topic] = progress;
    saveProgressToFirestore();
    notifyListeners();
  }

  void addMasteredCard(String topic, String language, String card) {
    _masteredCards[language] ??= {};
    _masteredCards[language]![topic] ??= [];
    _masteredCards[language]![topic]!.add(card);
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
        final data = doc.data() as Map<String, dynamic>;
        final progressData = data['progress'] as Map<String, dynamic>? ?? {};
        final masteredCardsData = data['masteredCards'] as Map<String, dynamic>? ?? {};

        _progress = progressData.map((language, topics) {
          return MapEntry(language, Map<String, double>.from(topics));
        });

        _masteredCards = masteredCardsData.map((language, topics) {
          final castedTopics = (topics as Map<String, dynamic>).map((topic, cards) {
            final castedCards = List<String>.from(cards as List<dynamic>);
            return MapEntry(topic, castedCards);
          });
          return MapEntry(language, castedTopics);
        });

        notifyListeners();
      } else {
        _progress = {};
        _masteredCards = {};
      }
    }
  }
}
