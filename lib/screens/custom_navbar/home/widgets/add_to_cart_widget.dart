import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/cart_controller.dart';
import 'package:onebite_user_app/models/menu_model.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:onebite_user_app/widgets/buttons.dart';
import 'package:provider/provider.dart';

class AddToCartWidget extends StatelessWidget {
  final MenuModel menu;
  final double? width;

  const AddToCartWidget({super.key, required this.menu, this.width});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, child) {
        final quantity = cartController.getItemQuantity(menu.id!);
        final cartId = cartController.getCartIdByRestaurant(
          menu.restaurantId?.id ?? '',
        );

        return SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width * 0.6,
          child: quantity > 0
              ? _buildCounter(context, cartController, quantity, cartId)
              : _buildAddButton(context, cartController),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context, CartController cartController) {
    return PrimaryButton(
      title: cartController.isLoading ? "Adding..." : "Add To Cart",
      onPressed: cartController.isLoading
          ? null
          : () async {
              await cartController.addToCart(
                menuId: menu.id!,
                restaurantId: menu.restaurantId?.id ?? '',
                name: menu.name,
                price: menu.price,
                image: menu.image,
              );

              if (!context.mounted) return;

              if (cartController.errorMessage != null) {
                showCustomMsg(context, cartController.errorMessage!);
                cartController.clearError();
              } else {
                showCustomMsg(context, "${menu.name} added to cart!");
              }
            },
    );
  }

  Widget _buildCounter(
    BuildContext context,
    CartController cartController,
    int quantity,
    String? cartId,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Decrement
        _counterButton(
          icon: Icons.remove,
          isLoading: cartController.isRemoving(menu.id!),
          onPressed: () async {
            await cartController.decrementItem(
              cartId: cartId!,
              menuId: menu.id!,
            );

            if (!context.mounted) return;

            if (cartController.errorMessage != null) {
              showCustomMsg(context, cartController.errorMessage!);
              cartController.clearError();
            }
          },
        ),

        // Quantity
        Text(
          quantity.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Increment
        _counterButton(
          icon: Icons.add,
          isLoading: cartController.isLoading,
          onPressed: () async {
            await cartController.addToCart(
              menuId: menu.id!,
              restaurantId: menu.restaurantId?.id ?? '',
              name: menu.name,
              price: menu.price,
              image: menu.image,
            );

            if (!context.mounted) return;

            if (cartController.errorMessage != null) {
              showCustomMsg(context, cartController.errorMessage!);
              cartController.clearError();
            }
          },
        ),
      ],
    );
  }

  Widget _counterButton({
    required IconData icon,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Icon(icon, color: Colors.white),
      onPressed: isLoading ? null : onPressed,
    );
  }
}
