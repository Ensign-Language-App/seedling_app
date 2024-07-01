import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserController with ChangeNotifier {
  User? _user = FirebaseAuth.instance.currentUser;

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    _user = userCredential.user;
    notifyListeners();
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

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      print('Facebook login result: ${result.status}');
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        print('Facebook access token: ${accessToken.token}');
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        _user = userCredential.user;
        notifyListeners();
      } else {
        print('Facebook login failed: ${result.message}');
        throw FirebaseAuthException(
            message: 'Failed to sign in with Facebook',
            code: 'ERROR_FACEBOOK_LOGIN_FAILED');
      }
    } on PlatformException catch (e) {
      print('Failed to sign in with Facebook: $e');
      throw FirebaseAuthException(message: e.message, code: e.code);
    } catch (e) {
      print('An error occurred while signing in with Facebook: $e');
      throw FirebaseAuthException(message: e.toString(), code: 'ERROR_UNKNOWN');
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
