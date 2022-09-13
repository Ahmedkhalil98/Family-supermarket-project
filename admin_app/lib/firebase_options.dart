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
    apiKey: 'AIzaSyBG42fhwgWHRuFS8dUv1dQw8vMHeVttZ2w',
    appId: '1:180173627699:web:9afaf16a8b8ea7b95ede46',
    messagingSenderId: '180173627699',
    projectId: 'grocery-delivery-app-9805a',
    authDomain: 'grocery-delivery-app-9805a.firebaseapp.com',
    storageBucket: 'grocery-delivery-app-9805a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVU-Kg0f8mSdeB118pPp4xOoPVOA7KIGs',
    appId: '1:180173627699:android:527501644dfa60c15ede46',
    messagingSenderId: '180173627699',
    projectId: 'grocery-delivery-app-9805a',
    storageBucket: 'grocery-delivery-app-9805a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4WH9QVXejcYUYVIlYoYaAW6XQvFGWCZ8',
    appId: '1:180173627699:ios:fea226be14a64ba75ede46',
    messagingSenderId: '180173627699',
    projectId: 'grocery-delivery-app-9805a',
    storageBucket: 'grocery-delivery-app-9805a.appspot.com',
    androidClientId: '180173627699-8th2dehvbb5egt6r5rqt2gek99a4t00e.apps.googleusercontent.com',
    iosClientId: '180173627699-663b8gtq4b5vi6mc1h4hf39dpfce852c.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4WH9QVXejcYUYVIlYoYaAW6XQvFGWCZ8',
    appId: '1:180173627699:ios:fea226be14a64ba75ede46',
    messagingSenderId: '180173627699',
    projectId: 'grocery-delivery-app-9805a',
    storageBucket: 'grocery-delivery-app-9805a.appspot.com',
    androidClientId: '180173627699-8th2dehvbb5egt6r5rqt2gek99a4t00e.apps.googleusercontent.com',
    iosClientId: '180173627699-663b8gtq4b5vi6mc1h4hf39dpfce852c.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminapp',
  );
}