import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,

          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: AppColors.primaryBlack,
          ),
        ),
      ),
    );
  }
}
