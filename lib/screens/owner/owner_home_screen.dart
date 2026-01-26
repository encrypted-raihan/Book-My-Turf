import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Owner Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Bookings", style: AppTextStyles.title),
            const SizedBox(height: 12),
            Text("• 6:00–7:00 PM – Booked"),
            Text("• 7:00–8:00 PM – Available"),
          ],
        ),
      ),
    );
  }
}
