import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/cart_controller.dart';

class CartOrderSummaryWidget extends StatelessWidget {
  final CartController cartController;

  const CartOrderSummaryWidget({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    const deliveryFee = 200.0;
    const tax = 0.08;
    final subtotal = cartController.grandTotal;
    final taxAmount = subtotal * tax;
    final total = subtotal + deliveryFee + taxAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                "Rs ${subtotal.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Delivery Fee",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                "Rs ${deliveryFee.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tax & Fees",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                "Rs ${taxAmount.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFF2A2A2A)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Rs ${total.toStringAsFixed(2)}",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
