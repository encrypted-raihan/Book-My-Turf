import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class HomeHeader extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 72;

  @override
  double get maxExtent => 120;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Transform.scale(
            scale: 1 - (progress * 0.1),
            alignment: Alignment.centerLeft,
            child: Text(
              "Book My Turf",
              style: AppTextStyles.title.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          Opacity(
            opacity: 1 - progress,
            child: Transform.translate(
              offset: Offset(0, -8 * progress),
              child: Text(
                "Find & book sports turfs near you",
                style: AppTextStyles.body.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeader oldDelegate) => false;
}
