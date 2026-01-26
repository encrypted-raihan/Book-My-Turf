import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile", style: AppTextStyles.title),
    );
  }
}
