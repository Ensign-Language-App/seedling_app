import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserController with ChangeNotifier {
  User? _user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw PlatformException(
          code: 'sign_in_canceled',
          message: 'Sign in aborted by user',
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKENS',
          message: 'Missing Google Auth Tokens',
        );
      }

      // Use these tokens to authenticate with Firebase or your backend
      print('Sign in successful: Access Token: ${googleAuth.accessToken}, ID Token: ${googleAuth.idToken}');
    } catch (error) {
      if (error is PlatformException && error.code == 'sign_in_canceled') {
        print('Sign in cancelled by user');
      } else {
        print('An error occurred while signing in with Google: $error');
      }
    }
  }

  Future<void> signInWithApple() async {
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

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      _user = userCredential.user;

      if (appleCredential.givenName != null || appleCredential.familyName != null) {
        final displayName = '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim();
        await _user!.updateDisplayName(displayName);
      }
      notifyListeners();
    } on PlatformException catch (e) {
      // TODO: REMOVE PRINT ON PRODUCTION
      print('Failed to sign in with Apple: $e');
      throw FirebaseAuthException(message: e.message, code: e.code);
    } catch (e) {
      // TODO: REMOVE PRINT ON PRODUCTION
      print('An error occurred while signing in with Apple: $e');
      throw FirebaseAuthException(message: e.toString(), code: 'ERROR_UNKNOWN');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print('An error occurred while signing in');
    }
  }


  Future<void> registerWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // _user = userCredential.user;

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


  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _user = null;
    notifyListeners();
  }
}
