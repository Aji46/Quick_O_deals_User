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
    apiKey: 'AIzaSyC64sHg59kVrTjm2IC4ueuq2qaTht2-bmU',
    appId: '1:874253348818:web:12137a642eefb4a3ae220b',
    messagingSenderId: '874253348818',
    projectId: 'quick-o-deals',
    authDomain: 'quick-o-deals.firebaseapp.com',
    databaseURL: 'https://quick-o-deals-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quick-o-deals.appspot.com',
    measurementId: 'G-MX97WM807Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoTQJTArWa8N3n5q4fFRXbXBqKhtVbC0k',
    appId: '1:874253348818:android:d8304d482d70e4c6ae220b',
    messagingSenderId: '874253348818',
    projectId: 'quick-o-deals',
    databaseURL: 'https://quick-o-deals-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quick-o-deals.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsySqICsTkMszCJIr2BZBc_bNtVZgPxh8',
    appId: '1:874253348818:ios:856e7dc4fa2c851dae220b',
    messagingSenderId: '874253348818',
    projectId: 'quick-o-deals',
    databaseURL: 'https://quick-o-deals-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quick-o-deals.appspot.com',
    iosBundleId: 'com.example.quickODeals',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsySqICsTkMszCJIr2BZBc_bNtVZgPxh8',
    appId: '1:874253348818:ios:856e7dc4fa2c851dae220b',
    messagingSenderId: '874253348818',
    projectId: 'quick-o-deals',
    databaseURL: 'https://quick-o-deals-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quick-o-deals.appspot.com',
    iosBundleId: 'com.example.quickODeals',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC64sHg59kVrTjm2IC4ueuq2qaTht2-bmU',
    appId: '1:874253348818:web:f4a099e55bd782caae220b',
    messagingSenderId: '874253348818',
    projectId: 'quick-o-deals',
    authDomain: 'quick-o-deals.firebaseapp.com',
    databaseURL: 'https://quick-o-deals-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quick-o-deals.appspot.com',
    measurementId: 'G-SC93FLCDSS',
  );
}
