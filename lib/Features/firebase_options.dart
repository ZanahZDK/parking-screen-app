// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCDOno0nA-fZa1tiXBNrsvo30a0u9Kmhh4',
    appId: '1:887979619304:web:0771405aab6ac2a609aa5d',
    messagingSenderId: '887979619304',
    projectId: 'sparking-399700',
    authDomain: 'sparking-399700.firebaseapp.com',
    storageBucket: 'sparking-399700.appspot.com',
    measurementId: 'G-L4DPMC5TCC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdYjyLmpI_RUulaqRuLuA23NvPxTNExZ4',
    appId: '1:887979619304:android:4d78f778b116774509aa5d',
    messagingSenderId: '887979619304',
    projectId: 'sparking-399700',
    storageBucket: 'sparking-399700.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBe8vqOn7crd9570USZC9ulEJzfVUxUWO8',
    appId: '1:887979619304:ios:53610d98464fba6d09aa5d',
    messagingSenderId: '887979619304',
    projectId: 'sparking-399700',
    storageBucket: 'sparking-399700.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBe8vqOn7crd9570USZC9ulEJzfVUxUWO8',
    appId: '1:887979619304:ios:d259d8daef4df1f609aa5d',
    messagingSenderId: '887979619304',
    projectId: 'sparking-399700',
    storageBucket: 'sparking-399700.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
