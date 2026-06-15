import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../models/cart_model.dart';
import '../../home/widgets/place_holder_widget.dart';
import 'cart_item_counter.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final CartModel cart;
  final CartController cartController;

  const CartItemTile({
    super.key,
    required this.item,
    required this.cart,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.image.isNotEmpty
                ? Image.network(
                    item.image,
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => placeHolderWidget(),
                  )
                : placeHolderWidget(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rs ${(item.price * item.quantity).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: cartController.isRemoving(item.menuId)
                ? null
                : () async {
                    await cartController.removeFromCart(
                      cartId: cart.id,
                      menuId: item.menuId,
                    );
                  },
          ),
          CartItemCounter(
            item: item,
            cart: cart,
            cartController: cartController,
          ),
        ],
      ),
    );
  }
}
