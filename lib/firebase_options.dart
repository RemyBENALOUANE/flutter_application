// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCOJKvliBkHCEXJWwrg-QS5sW1pvXmRwc8',
    appId: '1:615027268475:web:b3427b3e3ae35ff6873bde',
    messagingSenderId: '615027268475',
    projectId: 'flutter-application-999e7',
    authDomain: 'flutter-application-999e7.firebaseapp.com',
    storageBucket: 'flutter-application-999e7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjsc4rzviECuOcACZfNm-b_n-20OoCzBU',
    appId: '1:615027268475:android:f575148cc9dae0f3873bde',
    messagingSenderId: '615027268475',
    projectId: 'flutter-application-999e7',
    storageBucket: 'flutter-application-999e7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBi9EJJEt7iWRYX0J8To4WaTN0vhkYI0sY',
    appId: '1:615027268475:ios:417e2a8bb7af3d76873bde',
    messagingSenderId: '615027268475',
    projectId: 'flutter-application-999e7',
    storageBucket: 'flutter-application-999e7.appspot.com',
    iosBundleId: 'com.example.flutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBi9EJJEt7iWRYX0J8To4WaTN0vhkYI0sY',
    appId: '1:615027268475:ios:a11106634edb2c12873bde',
    messagingSenderId: '615027268475',
    projectId: 'flutter-application-999e7',
    storageBucket: 'flutter-application-999e7.appspot.com',
    iosBundleId: 'com.example.flutterApplication.RunnerTests',
  );
}
