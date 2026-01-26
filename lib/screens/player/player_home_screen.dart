import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import 'turf_detail_screen.dart';

class PlayerHomeScreen extends StatelessWidget {
  const PlayerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// HEADER — SINGLE, SOLID BLOCK
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.black54,
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Book My Turf",
                    style: AppTextStyles.title.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Find & book sports turfs near you",
                    style: AppTextStyles.body.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// CONTENT
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const _TurfCard();
                },
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
