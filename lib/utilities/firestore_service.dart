// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class FirestoreService {
  static Future<void> saveUser(String firstName, String lastName,
      String userName, String email, String password) async {
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    try {
      await FirebaseFirestore.instance.collection('Users').doc(userName).set({
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': hashedPassword,
      });
      print('User saved successfully');
    } catch (e) {
      print('Error saving user: $e');
      // Handle errors as needed
    }
  }
}
