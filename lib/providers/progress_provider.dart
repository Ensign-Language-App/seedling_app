import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

  Map<String, double> _progress = {};
  Map<String, List<String>> _masteredCards = {};

  double getProgress(String topic) {
    return _progress[topic] ?? 0.0;
  }

  List<String> getMasteredCards(String topic) {
    return _masteredCards[topic] ?? [];
  }

  void setProgress(String topic, double progress) {
    _progress[topic] = progress;
    saveProgressToFirestore();
    notifyListeners();
  }

  void addMasteredCard(String topic, String card) {
    if (_masteredCards.containsKey(topic)) {
      _masteredCards[topic]!.add(card);
    } else {
      _masteredCards[topic] = [card];
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
        _progress = Map<String, double>.from(doc.get('progress') ?? {});
        Map<String, dynamic> masteredCardsDynamic = doc.get('masteredCards') ?? {};
        _masteredCards = masteredCardsDynamic.map((key, value) => MapEntry(key, List<String>.from(value)));
        notifyListeners();
      }
    }
  }
}
