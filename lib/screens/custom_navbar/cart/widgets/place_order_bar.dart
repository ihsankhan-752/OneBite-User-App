import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/cart_controller.dart';

class PlaceOrderBar extends StatelessWidget {
  final bool isLoading;
  final CartController cartController;
  final VoidCallback onPressed;

  const PlaceOrderBar({
    super.key,
    required this.isLoading,
    required this.cartController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const deliveryFee = 200.0;
    const tax = 0.08;
    final total =
        cartController.grandTotal +
        deliveryFee +
        (cartController.grandTotal * tax);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  "Place Order • Rs ${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
