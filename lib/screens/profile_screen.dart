import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/neon_layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const NeonHero(
            headline: "Your Profile",
            subtitle: "Account & preferences",
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: GlassSection(
                title: "Account",
                child: Column(
                  children: const [
                    SizedBox(height: 24),
                    ListTile(
                      leading:
                          Icon(Icons.person, color: Colors.white70),
                      title: Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.settings, color: Colors.white70),
                      title: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
