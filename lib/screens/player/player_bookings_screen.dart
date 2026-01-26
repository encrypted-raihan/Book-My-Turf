import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class PlayerBookingsScreen extends StatelessWidget {
  const PlayerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER (NO BACK BUTTON)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: const Border(
                bottom: BorderSide(color: Colors.black54, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Bookings",
                  style: AppTextStyles.title.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),

          // CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  _BookingCard(
                    turf: "Greenfield Turf",
                    date: "Today • 24 Jan",
                    time: "6:00 – 7:00 PM",
                    status: "Confirmed",
                  ),
                  _BookingCard(
                    turf: "Greenfield Turf",
                    date: "Tomorrow • 25 Jan",
                    time: "7:00 – 8:00 PM",
                    status: "Upcoming",
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

class _BookingCard extends StatelessWidget {
  final String turf;
  final String date;
  final String time;
  final String status;

  const _BookingCard({
    required this.turf,
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool confirmed = status == "Confirmed";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            turf,
            style: AppTextStyles.title.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text("$date • $time", style: AppTextStyles.body),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              status,
              style: AppTextStyles.body.copyWith(
                color:
                    confirmed ? Colors.greenAccent : Colors.orangeAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
