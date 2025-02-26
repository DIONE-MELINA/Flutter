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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBISkV9pbiFeprydq6KNbTkhJo3cJQ7pM',
    appId: '1:353023281468:android:964d9f20eba905fc4fb639',
    messagingSenderId: '353023281468',
    projectId: 'simpleoperations-1d3bf',
    databaseURL: 'https://simpleoperations-1d3bf-default-rtdb.firebaseio.com',
    storageBucket: 'simpleoperations-1d3bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAknSJEzfQZdkVNIO6A1-nzHNf5eI5G45w',
    appId: '1:353023281468:ios:86e8cf5a37c7bbc54fb639',
    messagingSenderId: '353023281468',
    projectId: 'simpleoperations-1d3bf',
    databaseURL: 'https://simpleoperations-1d3bf-default-rtdb.firebaseio.com',
    storageBucket: 'simpleoperations-1d3bf.appspot.com',
    iosBundleId: 'com.example.crudOperation',
  );
}
