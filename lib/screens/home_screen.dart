import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/neon_layout.dart';
import '../widgets/turf_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const NeonHero(
            headline: "Tonight’s Game",
            subtitle: "Neon lights · Premium turfs · Instant booking",
          ),

          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: Column(
                children: [
                  GlassSection(
                    title: "Featured",
                    child: Column(
                      children: const [
                        SizedBox(height: 24),
                        TurfCard(
                          name: "Elite Sports Hub",
                          features: "Football • 5v5 • Premium turf",
                          price: "₹1400 / hour",
                          location: "Kollam",
                          rating: 4.8,
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  GlassSection(
                    title: "Popular Near You",
                    child: Column(
                      children: const [
                        SizedBox(height: 24),
                        TurfCard(
                          name: "Green Valley Turf",
                          features: "Football • 7v7 • Night lights",
                          price: "₹1200 / hour",
                          location: "Kottarakkara",
                          rating: 4.6,
                        ),
                        TurfCard(
                          name: "City Arena",
                          features: "Cricket • Box ground",
                          price: "₹1000 / hour",
                          location: "Kollam",
                          rating: 4.3,
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  GlassSection(
                    title: "Nearby",
                    child: Column(
                      children: const [
                        SizedBox(height: 24),
                        TurfCard(
                          name: "PlayZone Turf",
                          features: "Football • 6v6",
                          price: "₹900 / hour",
                          location: "Pathanapuram",
                          rating: 4.2,
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120), // space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
