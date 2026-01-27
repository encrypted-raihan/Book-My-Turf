import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import 'turf_detail_screen.dart';

class PlayerHomeScreen extends StatefulWidget {
  const PlayerHomeScreen({super.key});

  @override
  State<PlayerHomeScreen> createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  String _locationText = "Detecting location…";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _locationText = "Location disabled";
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final place = placemarks.first;

      setState(() {
        _locationText =
            place.locality ?? place.subAdministrativeArea ?? "Your area";
      });
    } catch (_) {
      setState(() {
        _locationText = "Unable to get location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _HomeHeaderDelegate(location: _locationText),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const _TurfCard();
                },
                childCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= HEADER DELEGATE ================= */

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String location;

  _HomeHeaderDelegate({required this.location});

  @override
  double get minExtent => 68;

  @override
  double get maxExtent => 110;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final double titleSize = 25 - (3 * progress);
    final double titleTop = 16 - (6 * progress);

    return Container(
      color: AppColors.background,
      child: Stack(
        children: [
          // TITLE
          Positioned(
            left: 20,
            top: titleTop,
            child: Text(
              "Book My Turf",
              style: AppTextStyles.title.copyWith(
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // SUBTITLE
          Positioned(
            left: 20,
            top: titleTop + 34,
            child: Opacity(
              opacity: 1 - progress,
              child: Text(
                "Find & book sports turfs near you",
                style: AppTextStyles.body.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

          // LOCATION CHIP
          Positioned(
            left: 20,
            bottom: 12,
            child: Opacity(
              opacity: 1 - progress,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.greenAccent),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) => true;
}

/* ================= TURF CARD ================= */

class _TurfCard extends StatelessWidget {
  const _TurfCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TurfDetailScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Greenfield Turf",
              style: AppTextStyles.title.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              "Football • Cricket",
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 12),
            Text(
              "₹1200 / hour",
              style: AppTextStyles.body.copyWith(
                color: Colors.greenAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
