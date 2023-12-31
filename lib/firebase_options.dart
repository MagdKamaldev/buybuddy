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
    apiKey: 'AIzaSyDegJhJKPUiRIo5pu8YfmezV5Ku6YnjNBs',
    appId: '1:836917147552:web:a6431476e03059737496c5',
    messagingSenderId: '836917147552',
    projectId: 'buybuddy-83f35',
    authDomain: 'buybuddy-83f35.firebaseapp.com',
    storageBucket: 'buybuddy-83f35.appspot.com',
    measurementId: 'G-S7Y4R9TBBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJoEwsjQCkx3hZdtjA1xLvbmGiEk-ikTk',
    appId: '1:836917147552:android:5f98d8b44e3229f37496c5',
    messagingSenderId: '836917147552',
    projectId: 'buybuddy-83f35',
    storageBucket: 'buybuddy-83f35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1QdULLOi8RQm0vrop8A52SfLCQV3aHBs',
    appId: '1:836917147552:ios:eac1faa12d0f24427496c5',
    messagingSenderId: '836917147552',
    projectId: 'buybuddy-83f35',
    storageBucket: 'buybuddy-83f35.appspot.com',
    iosClientId: '836917147552-2a14110smtj4r8u8o9aqt9j3909vklnm.apps.googleusercontent.com',
    iosBundleId: 'com.example.buybuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1QdULLOi8RQm0vrop8A52SfLCQV3aHBs',
    appId: '1:836917147552:ios:3078b6f12e35c5b87496c5',
    messagingSenderId: '836917147552',
    projectId: 'buybuddy-83f35',
    storageBucket: 'buybuddy-83f35.appspot.com',
    iosClientId: '836917147552-ef8ms59rpnt87ltqage8osa8vjft78k6.apps.googleusercontent.com',
    iosBundleId: 'com.example.buybuddy.RunnerTests',
  );
}
