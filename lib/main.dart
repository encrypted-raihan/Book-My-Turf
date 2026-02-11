import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/loading_screen.dart';
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
      home: const AppLaunchScreen(),
    );
  }
}

class AppLaunchScreen extends StatefulWidget {
  const AppLaunchScreen({super.key});

  @override
  State<AppLaunchScreen> createState() => _AppLaunchScreenState();
}

class _AppLaunchScreenState extends State<AppLaunchScreen> {
  bool _showMainApp = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      setState(() => _showMainApp = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _showMainApp
          ? const MainNavWrapper(key: ValueKey('main-nav'))
          : const LoadingScreen(key: ValueKey('loading-screen')),
    );
  }
}
