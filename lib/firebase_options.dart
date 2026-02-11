import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are configured only for web in this project. '
      'Run flutterfire configure for Android/iOS/macOS.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzgMJ2vceUjMr9UZ7SgoAswVE2Rcw3zB8',
    authDomain: 'book-my-turf-1d773.firebaseapp.com',
    projectId: 'book-my-turf-1d773',
    storageBucket: 'book-my-turf-1d773.firebasestorage.app',
    messagingSenderId: '122678708701',
    appId: '1:122678708701:web:9736f15b10e79c4bf50e34',
    measurementId: 'G-02BHC781HW',
  );
}
