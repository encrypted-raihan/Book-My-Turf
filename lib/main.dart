import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BookMyTurfApp());
}

class BookMyTurfApp extends StatelessWidget {
  const BookMyTurfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090B),
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
        primaryColor: const Color(0xFFA061FF),
      ),
      home: const LoginScreen(),
    );
  }
}
