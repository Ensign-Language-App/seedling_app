import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

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
}
