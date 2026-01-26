import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text("Owner Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earnings card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Earnings",
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹6,000",
                    style: AppTextStyles.title.copyWith(
                      color: Colors.greenAccent,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Today's Bookings",
              style: AppTextStyles.title,
            ),

            const SizedBox(height: 12),

            _BookingRow(
              time: "6:00 – 7:00 PM",
              status: "Booked",
            ),
            _BookingRow(
              time: "7:00 – 8:00 PM",
              status: "Booked",
            ),
            _BookingRow(
              time: "8:00 – 9:00 PM",
              status: "Available",
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  final String time;
  final String status;

  const _BookingRow({
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBooked = status == "Booked";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            status,
            style: AppTextStyles.body.copyWith(
              color: isBooked
                  ? Colors.redAccent
                  : Colors.greenAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
