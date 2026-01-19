import 'package:flutter/material.dart';
import '../widgets/turf_card.dart';
import '../constants/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          _HeroHeader(),
          SizedBox(height: 16),

          _AnimatedTurfCard(
            delay: 0,
            card: TurfCard(
              name: "Green Valley Turf",
              features: "Football • 7v7 • Night lights",
              price: "₹1200 / hour",
              location: "Kottarakkara",
              rating: 4.6,
            ),
          ),

          _AnimatedTurfCard(
            delay: 150,
            card: TurfCard(
              name: "City Arena",
              features: "Cricket • Box ground",
              price: "₹1000 / hour",
              location: "Kollam",
              rating: 4.3,
            ),
          ),

          _AnimatedTurfCard(
            delay: 300,
            card: TurfCard(
              name: "Elite Sports Hub",
              features: "Football • 5v5",
              price: "₹800 / hour",
              location: "Pathanapuram",
              rating: 4.8,
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                HERO HEADER                                 */
/* -------------------------------------------------------------------------- */

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 64, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1DB954),
            Color(0xFF0F2F1E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Book your game tonight ⚽",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Premium turfs near you · Night matches ready",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                           ANIMATED CARD WRAPPER                             */
/* -------------------------------------------------------------------------- */

class _AnimatedTurfCard extends StatelessWidget {
  final Widget card;
  final int delay;

  const _AnimatedTurfCard({
    required this.card,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 24),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: card,
    );
  }
}
