import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Avatar
          const CircleAvatar(
            radius: 44,
            backgroundColor: kPrimaryColor,
            child: Text(
              "R",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Name
          const Text(
            "Raihan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kTextColor,
            ),
          ),

          const SizedBox(height: 4),

          // Phone
          const Text(
            "+91 98765 43210",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 32),

          _profileTile(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {},
          ),

          _profileTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {},
          ),

          _profileTile(
            icon: Icons.logout,
            title: "Logout",
            isDestructive: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : kPrimaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : kTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
