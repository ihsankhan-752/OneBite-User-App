import 'package:flutter/material.dart';
import 'package:onebite_user_app/screens/custom_navbar/widgets/badge_widget.dart';

class BottomTabWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onPressed;
  final int badgeCount;

  const BottomTabWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.onPressed,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: activeColor),
              const SizedBox(height: 4),
              Text(title, style: TextStyle(color: activeColor, fontSize: 11)),
            ],
          ),
          if (badgeCount > 0)
            Positioned(top: 4, right: 4, child: BadgeWidget(count: badgeCount)),
        ],
      ),
    );
  }
}
