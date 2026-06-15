import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/cart_controller.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/cart_checkout_bar.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/cart_item_tile.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/cart_order_summary_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartController>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        actions: [
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          if (cartController.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (cartController.errorMessage != null) {
            return Center(
              child: Text(
                cartController.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (cartController.carts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your cart is empty",
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      "Items",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...cartController.carts.expand(
                      (cart) => cart.items.map(
                        (item) => CartItemTile(
                          item: item,
                          cart: cart,
                          cartController: cartController,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    CartOrderSummaryWidget(cartController: cartController),
                  ],
                ),
              ),
              CartCheckoutBar(cartController: cartController),
            ],
          );
        },
      ),
    );
  }
}
