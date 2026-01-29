import 'package:flutter/material.dart'; // Removed dart:ui as material provides the same elements
import 'slot_selection_screen.dart';

class TurfDetailScreen extends StatelessWidget {
  const TurfDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundEffect(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Icon(
                    Icons.sports_soccer_rounded,
                    size: 160,
                    color: Color(0xFFA061FF),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBadge("PREMIUM TURF"),
                      const SizedBox(height: 15),
                      const Text(
                        "Greenfield Arena",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Kollam, Kerala • 5.0 ★",
                        style: TextStyle(color: Colors.white38, fontSize: 16),
                      ),
                      const SizedBox(height: 35),
                      _buildInfoTile(Icons.timer_outlined, "Duration", "60 Minutes"),
                      _buildInfoTile(Icons.groups_outlined, "Capacity", "5v5 / 7v7"),
                      _buildInfoTile(Icons.wb_sunny_outlined, "Floodlights", "Available"),
                      
                      // FIXED: Changed Checkroom_outlined to checkroom_outlined
                      _buildInfoTile(Icons.checkroom_outlined, "Locker Room", "Provided"),

                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFA061FF), Color(0xFF7000FF)],
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFA061FF).withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (c) => const SlotSelectionScreen()),
                              );
                            },
                            child: const Text(
                              "CHOOSE TIME SLOT",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundEffect() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          radius: 1.0,
          colors: [Color(0xFF1E1B4B), Color(0xFF09090B)],
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFA061FF).withValues(alpha: 0.15),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
        border: Border.all(color: const Color(0xFFA061FF).withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFA061FF),
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFA061FF), size: 24),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(color: Colors.white38)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}