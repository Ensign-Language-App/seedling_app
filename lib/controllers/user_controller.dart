// ignore_for_file: avoid_print
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserController with ChangeNotifier {
  User? _user = FirebaseAuth.instance.currentUser;
  User? get user => _user;

  final ImagePicker _picker = ImagePicker();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(
          code: 'sign_in_canceled',
          message: 'Sign in aborted by user',
        );
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      _user = userCredential.user;
      notifyListeners();

      // Load progress for the new user after notifying listeners
      await Provider.of<ProgressProvider>(context, listen: false)
          .loadProgressFromFirestore();
    } catch (error) {
      if (error is PlatformException && error.code == 'sign_in_canceled') {
        print('Sign in cancelled by user');
      } else {
        print('An error occurred while signing in with Google: $error');
      }
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      _user = userCredential.user;

      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        final displayName =
        '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
            .trim();
        await _user!.updateDisplayName(displayName);
      }
      notifyListeners();

      // Load progress for the new user after notifying listeners
      await Provider.of<ProgressProvider>(context, listen: false)
          .loadProgressFromFirestore();
    } on PlatformException catch (e) {
      print('Failed to sign in with Apple: $e');
      throw FirebaseAuthException(message: e.message, code: e.code);
    } catch (e) {
      print('An error occurred while signing in with Apple: $e');
      throw FirebaseAuthException(message: e.toString(), code: 'ERROR_UNKNOWN');
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();

      // Load progress for the new user after notifying listeners
      await Provider.of<ProgressProvider>(context, listen: false)
          .loadProgressFromFirestore();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print('An error occurred while signing in');
    }
  }

  Future<void> registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_user != null) {
        await _user!.updateDisplayName("$firstName $lastName");
        await _user!.reload();
        _user = FirebaseAuth.instance.currentUser;
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print('An error occurred while registering: $e');
      rethrow;
    }
  }

  Future<void> updateUserName(String newName) async {
    if (_user != null) {
      try {
        await _user!.updateDisplayName(newName);
        await _user!.reload();
        _user = FirebaseAuth.instance.currentUser;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        print('Failed to update user name: $e');
        throw e;
      } catch (e) {
        print('An error occurred while updating the user name: $e');
        throw e;
      }
    }
  }

  Future<void> updateProfilePicture() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${_user!.uid}.jpg');
        await storageRef.putFile(file);
        final photoURL = await storageRef.getDownloadURL();
        await _user!.updatePhotoURL(photoURL);
        await _user!.reload();
        _user = FirebaseAuth.instance.currentUser;
        notifyListeners();
      }
    } catch (e) {
      print('Failed to update profile picture: $e');
      throw e;
    }
  }

  Future<void> signOut(BuildContext context) async {
    // Save progress before logging out
    await Provider.of<ProgressProvider>(context, listen: false)
        .saveProgressToFirestore();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      // Ensure the user is authenticated before deleting
      if (_user != null) {
        await _user!.delete();
        _user = null;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account successfully deleted')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is currently signed in')),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Failed to delete account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account: ${e.message}')),
      );
    } catch (e) {
      print('An error occurred while deleting the account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
