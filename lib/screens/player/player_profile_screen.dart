import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

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
                  "Profile",
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey.shade800,
                          child: const Icon(Icons.person,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Raihan",
                              style: AppTextStyles.title
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "+91 9XXXXXXXXX",
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  _ProfileTile(
                    icon: Icons.logout,
                    label: "Logout",
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.pop(context); // go back to login
                    },
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

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
