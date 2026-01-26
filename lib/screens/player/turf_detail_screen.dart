import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/gradients.dart';
import '../../theme/text_styles.dart';
import '../../widgets/gradient_button.dart';
import 'booking_success_screen.dart';

class TurfDetailScreen extends StatefulWidget {
  const TurfDetailScreen({super.key});

  @override
  State<TurfDetailScreen> createState() => _TurfDetailScreenState();
}

class _TurfDetailScreenState extends State<TurfDetailScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final bool isSlotSelected = selectedIndex != null;

    return Scaffold(
      body: Column(
        children: [
          /// CUSTOM HEADER (FIXES BACK BUTTON + TITLE VISIBILITY)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: const Border(
                bottom: BorderSide(color: Colors.black54, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Greenfield Turf",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// DATE + PRICE SUMMARY
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today • 24 Jan",
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Football • Cricket",
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                        Text(
                          "₹1200 / hour",
                          style: AppTextStyles.body.copyWith(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Available Slots",
                    style: AppTextStyles.title,
                  ),

                  const SizedBox(height: 16),

                  /// SLOTS
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(6, (index) {
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? null : AppColors.card,
                            gradient:
                                isSelected ? AppGradients.primary : null,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.35),
                                      blurRadius: 18,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            "${5 + index}:00 - ${6 + index}:00",
                            style: AppTextStyles.body.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  /// BOOK BUTTON
                  Opacity(
                    opacity: isSlotSelected ? 1 : 0.4,
                    child: GradientButton(
                      text: "Book Slot",
                      onTap: isSlotSelected
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const BookingSuccessScreen(),
                                ),
                              );
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
