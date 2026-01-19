import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

class TimeSlotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback? onTap;

  const TimeSlotChip({
    super.key,
    required this.time,
    required this.isSelected,
    required this.isBooked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isBooked
        ? Colors.grey.shade800
        : isSelected
            ? kPrimaryColor
            : const Color(0xFF1E1E1E);

    final Color textColor = isBooked
        ? Colors.grey
        : isSelected
            ? Colors.black
            : Colors.white;

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              HapticFeedback.selectionClick();
              onTap?.call();
            },
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
