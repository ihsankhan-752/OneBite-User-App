import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../models/cart_model.dart';

class CartItemCounter extends StatelessWidget {
  final CartItemModel item;
  final CartModel cart;
  final CartController cartController;

  const CartItemCounter({
    super.key,
    required this.item,
    required this.cart,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _counterBtn(
          icon: Icons.remove,
          isLoading: cartController.isRemoving(item.menuId),
          onPressed: () async {
            await cartController.decrementItem(
              cartId: cart.id,
              menuId: item.menuId,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _counterBtn(
          icon: Icons.add,
          isLoading: cartController.isAdding(item.menuId),
          onPressed: () async {
            await cartController.addToCart(
              menuId: item.menuId,
              restaurantId: cart.restaurantId,
              name: item.name,
              price: item.price,
              image: item.image,
            );
          },
        ),
      ],
    );
  }

  Widget _counterBtn({
    required IconData icon,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
