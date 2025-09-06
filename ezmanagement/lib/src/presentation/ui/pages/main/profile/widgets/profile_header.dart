import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class ProfileHeader extends StatelessWidget {
  final Color textColor;

  const ProfileHeader({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
            backgroundColor: EZColorsApp.ezAppColor.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 12),
          Text(
            'Maria Celeste',
            style: TextStyle(
              fontFamily: 'OpenSansHebrew',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
