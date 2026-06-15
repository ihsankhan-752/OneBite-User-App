import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/models/menu_model.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/add_to_cart_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/place_holder_widget.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_controller.dart';

class MenuDetailScreen extends StatelessWidget {
  final MenuModel menu;

  const MenuDetailScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(menu.name)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: menu.image.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      width: double.infinity,
                      child: Image.network(
                        menu.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => placeHolderWidget(),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      width: double.infinity,
                      child: placeHolderWidget(),
                    ),
            ),
            SizedBox(height: 20),

            Text(
              menu.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryWhite,
              ),
            ),
            SizedBox(height: 20),
            Text(
              menu.description,
              style: TextStyle(fontSize: 18, color: AppColors.primaryWhite),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.cardBg)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<CartController>(
                builder: (context, cartController, child) {
                  final quantity = cartController.getItemQuantity(menu.id!);
                  final totalPrice = menu.price * (quantity > 0 ? quantity : 1);

                  return Text(
                    "Rs ${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              AddToCartWidget(menu: menu),
            ],
          ),
        ),
      ),
    );
  }
}
