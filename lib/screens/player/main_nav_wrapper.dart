import 'package:flutter/material.dart';
import 'player_home_screen.dart';
import 'player_bookings_screen.dart';
import 'player_profile_screen.dart';

class MainNavWrapper extends StatefulWidget {
  const MainNavWrapper({super.key});
  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const PlayerHomeScreen(),
    const Center(child: Text("Search Screen")),
    const PlayerBookingsScreen(),
    const PlayerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_filled, 0),
            _navItem(Icons.search, 1),
            _navItem(Icons.calendar_today_rounded, 2),
            _navItem(Icons.person_outline_rounded, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: active ? const LinearGradient(colors: [Color(0xFFA061FF), Color(0xFF7000FF)]) : null,
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.white38),
      ),
    );
  }
}