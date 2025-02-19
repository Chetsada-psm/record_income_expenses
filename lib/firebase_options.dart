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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD62mY9WW2LeIt-Pyy3ssjzsPEDpNuuzuY',
    appId: '1:205965708378:web:44fd7a358cec8d4c231c63',
    messagingSenderId: '205965708378',
    projectId: 'record-income',
    authDomain: 'record-income.firebaseapp.com',
    storageBucket: 'record-income.appspot.com',
    measurementId: 'G-GYDK1199F2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv8V-Z3EVBoDWQrQlFPv5818XLTm9oOTQ',
    appId: '1:205965708378:android:74fb85e25ae8c4ea231c63',
    messagingSenderId: '205965708378',
    projectId: 'record-income',
    storageBucket: 'record-income.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD62mY9WW2LeIt-Pyy3ssjzsPEDpNuuzuY',
    appId: '1:205965708378:web:386dffc4149ba724231c63',
    messagingSenderId: '205965708378',
    projectId: 'record-income',
    authDomain: 'record-income.firebaseapp.com',
    storageBucket: 'record-income.appspot.com',
    measurementId: 'G-0E6WNWX6EY',
  );
}
