import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/screens/custom_navbar/custom_navbar.dart';
import 'package:onebite_user_app/widgets/buttons.dart';

class NoFavoriteItemWidget extends StatelessWidget {
  const NoFavoriteItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryWhite.withValues(alpha: 0.7),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite_border,
                  color: AppColors.primaryWhite,
                  size: 35,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "No favorites yet",
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Save your favorite restaurants\nto order again faster",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryWhite.withValues(alpha: 0.5),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 45,
              child: PrimaryButton(
                title: "Browse Restaurants",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CustomNavbar()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
