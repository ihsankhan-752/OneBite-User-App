import 'package:flutter/material.dart';
import 'package:onebite_user_app/widgets/buttons.dart';

import '../../../../controllers/cart_controller.dart';
import '../checkout_screen.dart';

class CartCheckoutBar extends StatelessWidget {
  final CartController cartController;

  const CartCheckoutBar({super.key, required this.cartController});

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
      child: PrimaryButton(
        title: "Proceed to Checkout • Rs ${total.toStringAsFixed(2)}",
        onPressed: () {
          final restaurantIds = cartController.carts
              .map((c) => c.restaurantId)
              .toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutScreen(restaurantIds: restaurantIds),
            ),
          );
        },
      ),
    );
  }
}
