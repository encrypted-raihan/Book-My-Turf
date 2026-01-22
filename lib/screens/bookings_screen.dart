import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/neon_layout.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const NeonHero(
            headline: "Your Bookings",
            subtitle: "Upcoming & past games",
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: GlassSection(
                title: "Upcoming",
                child: Column(
                  children: const [
                    SizedBox(height: 24),
                    ListTile(
                      title: Text(
                        "Green Valley Turf",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        "Today • 8:00 – 9:00 PM",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
