import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF2A2A2A)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E1E1E), Color(0xFF111111)],
              ),
            ),
            child: const Icon(
              Icons.restaurant_rounded,
              color: AppColors.primaryColor,
              size: 34,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Center(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'ONE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'BITE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 6),

        const Center(
          child: Text(
            'Food delivered fast',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
