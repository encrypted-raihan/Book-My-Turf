import 'package:flutter/material.dart';

class PlayerProfileScreen extends StatelessWidget {
  // FIXED: Changed super.super to super.key
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 80),
            // Avatar with Glow Effect
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFA061FF).withValues(alpha: 0.25),
                          blurRadius: 50,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xFF1E1B4B),
                    child: Icon(Icons.person_rounded, size: 70, color: Color(0xFFA061FF)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text("Raihan", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white)),
            const Text("Premium Player • Kollam", style: TextStyle(color: Color(0xFFA061FF), fontWeight: FontWeight.bold, letterSpacing: 1.1)),
            
            const SizedBox(height: 40),
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatTile("12", "Bookings"),
                _buildStatTile("4.9", "Rating"),
                _buildStatTile("5", "MVP"),
              ],
            ),
            
            const SizedBox(height: 40),
            // Glassmorphic Menu
            _buildProfileMenu(Icons.history_rounded, "Transaction History"),
            _buildProfileMenu(Icons.favorite_border_rounded, "Favorite Turfs"),
            _buildProfileMenu(Icons.settings_outlined, "App Settings"),
            _buildProfileMenu(Icons.support_agent_rounded, "Customer Support"),
            
            const SizedBox(height: 40),
            _buildLogoutBtn(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 13)),
      ],
    );
  }

  Widget _buildProfileMenu(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // User Preference
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFA061FF)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return TextButton(
      onPressed: () {},
      child: const Text("Sign Out", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800)),
    );
  }
}