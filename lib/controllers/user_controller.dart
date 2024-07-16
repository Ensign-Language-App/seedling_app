import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserController with ChangeNotifier {
  User? _user = FirebaseAuth.instance.currentUser;
  User? get user => _user;

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
        debugPrint('Sign in cancelled by user');
      } else {
        debugPrint('An error occurred while signing in with Google: $error');
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
      debugPrint('Failed to sign in with Apple: $e');
      throw FirebaseAuthException(message: e.message, code: e.code);
    } catch (e) {
      debugPrint('An error occurred while signing in with Apple: $e');
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
      debugPrint(e.message);
    } catch (e) {
      debugPrint('An error occurred while signing in');
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
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      debugPrint('An error occurred while registering: $e');
      rethrow;
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
}
