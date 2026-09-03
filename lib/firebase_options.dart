import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoWebApiKey123456789012345678901',
    appId: '1:123456789012:web:abcdef1234567890abcd',
    messagingSenderId: '123456789012',
    projectId: 'yourbself-premium-app',
    authDomain: 'yourbself-premium-app.firebaseapp.com',
    databaseURL: 'https://yourbself-premium-app.firebaseio.com',
    storageBucket: 'yourbself-premium-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoAndroidApiKey123456789012345678',
    appId: '1:123456789012:android:abcdef1234567890abcd',
    messagingSenderId: '123456789012',
    projectId: 'yourbself-premium-app',
    databaseURL: 'https://yourbself-premium-app.firebaseio.com',
    storageBucket: 'yourbself-premium-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoIOSApiKey123456789012345678901',
    appId: '1:123456789012:ios:abcdef1234567890abcd',
    messagingSenderId: '123456789012',
    projectId: 'yourbself-premium-app',
    databaseURL: 'https://yourbself-premium-app.firebaseio.com',
    storageBucket: 'yourbself-premium-app.appspot.com',
    iosBundleId: 'com.yourbself.premium.app',
  );
}
