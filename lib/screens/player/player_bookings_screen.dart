import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class PlayerBookingsScreen extends StatelessWidget {
  const PlayerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("My Bookings", style: AppTextStyles.title),
    );
  }
}
