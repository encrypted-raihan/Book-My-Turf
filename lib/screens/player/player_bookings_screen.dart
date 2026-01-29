import 'package:flutter/material.dart';

class PlayerBookingsScreen extends StatelessWidget {
  const PlayerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            backgroundColor: Color(0xFF09090B),
            floating: true,
            title: Text("My Bookings", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
            centerTitle: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildBookingCard(index == 0), // First one is "Active"
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
        border: Border.all(color: isActive ? const Color(0xFFA061FF).withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isActive ? "UPCOMING" : "COMPLETED", 
                    style: TextStyle(color: isActive ? const Color(0xFFA061FF) : Colors.white38, fontWeight: FontWeight.bold, fontSize: 10)),
                  const SizedBox(height: 5),
                  const Text("Greenfield Arena", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.confirmation_number_outlined, color: Color(0xFFA061FF)),
            ],
          ),
          const Divider(height: 30, color: Colors.white10),
          Row(
            children: [
              _infoItem(Icons.calendar_today, "24 Oct"),
              const SizedBox(width: 20),
              _infoItem(Icons.access_time, "10:00 AM"),
              const Spacer(),
              const Text("₹1,200", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white38),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}