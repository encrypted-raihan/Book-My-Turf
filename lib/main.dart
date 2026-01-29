import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/player/main_nav_wrapper.dart';

void main() => runApp(const BookMyTurfApp());

class BookMyTurfApp extends StatelessWidget {
  const BookMyTurfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090B), // Deepest Black
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
        primaryColor: const Color(0xFFA061FF), // Neon Purple
      ),
      home: const MainNavWrapper(),
    );
  }
}