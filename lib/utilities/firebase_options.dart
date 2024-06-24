// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDc9ejR2iygcS9AH8V7g6wREKOSNSuvEGU',
    appId: '1:202345167900:web:0f069d0b15bd42eda1f3d9',
    messagingSenderId: '202345167900',
    projectId: 'seedling-3aed4',
    authDomain: 'seedling-3aed4.firebaseapp.com',
    storageBucket: 'seedling-3aed4.appspot.com',
    measurementId: 'G-JH6W4KCB6P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8DfQvbnfKSszyfuJVSgrqHyXv4t8V6h8',
    appId: '1:202345167900:android:48b3e55cd2473d95a1f3d9',
    messagingSenderId: '202345167900',
    projectId: 'seedling-3aed4',
    storageBucket: 'seedling-3aed4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBH_vfhDjQOHaz-zMXHD1vdkRGlAt1F5qc',
    appId: '1:202345167900:ios:5d732fb082d2aab7a1f3d9',
    messagingSenderId: '202345167900',
    projectId: 'seedling-3aed4',
    storageBucket: 'seedling-3aed4.appspot.com',
    iosClientId:
        '202345167900-e5npivdjlpk0rq23us1cavc0d9sofehf.apps.googleusercontent.com',
    iosBundleId: 'com.example.seedlingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBH_vfhDjQOHaz-zMXHD1vdkRGlAt1F5qc',
    appId: '1:202345167900:ios:5d732fb082d2aab7a1f3d9',
    messagingSenderId: '202345167900',
    projectId: 'seedling-3aed4',
    storageBucket: 'seedling-3aed4.appspot.com',
    iosClientId:
        '202345167900-e5npivdjlpk0rq23us1cavc0d9sofehf.apps.googleusercontent.com',
    iosBundleId: 'com.example.seedlingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDc9ejR2iygcS9AH8V7g6wREKOSNSuvEGU',
    appId: '1:202345167900:web:afddc3b36121a806a1f3d9',
    messagingSenderId: '202345167900',
    projectId: 'seedling-3aed4',
    authDomain: 'seedling-3aed4.firebaseapp.com',
    storageBucket: 'seedling-3aed4.appspot.com',
    measurementId: 'G-L4GTZP4SMJ',
  );
}
