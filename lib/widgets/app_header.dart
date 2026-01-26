import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          if (onBack != null)
            GestureDetector(
              onTap: onBack,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),

          if (onBack != null) const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.title.copyWith(fontSize: 18),
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
