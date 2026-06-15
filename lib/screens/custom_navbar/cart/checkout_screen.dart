import 'package:flutter/material.dart';
import 'package:onebite_user_app/controllers/cart_controller.dart';
import 'package:onebite_user_app/controllers/order_controller.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/checkout_summary_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/payment_method_selector_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/widgets/place_order_bar.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:onebite_user_app/widgets/text_inputs.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<String> restaurantIds;

  const CheckoutScreen({super.key, required this.restaurantIds});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController();
  String _paymentMethod = "cash";

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.read<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Consumer<OrderController>(
        builder: (context, orderController, child) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      "Delivery Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AddressTextInput(controller: _addressController),
                    const SizedBox(height: 24),

                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    PaymentMethodSelectorWidget(
                      selected: _paymentMethod,
                      onChanged: (val) => setState(() => _paymentMethod = val),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CheckoutSummaryWidget(cartController: cartController),
                  ],
                ),
              ),

              PlaceOrderBar(
                isLoading: orderController.isLoading,
                cartController: cartController,
                onPressed: () async {
                  if (_addressController.text.trim().isEmpty) {
                    showCustomMsg(context, "Please enter delivery address");
                    return;
                  }

                  final orderController = context.read<OrderController>();
                  final cartController = context.read<CartController>();

                  await orderController.placeOrders(
                    restaurantIds: widget.restaurantIds,
                    deliveryAddress: _addressController.text.trim(),
                    paymentMethod: _paymentMethod,
                    context: context,
                  );

                  if (!context.mounted) return;

                  if (orderController.errorMessage != null) {
                    showCustomMsg(context, orderController.errorMessage!);
                    orderController.clearError();
                  } else {
                    cartController.clearCart();
                    showCustomMsg(context, "Orders placed successfully!");
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
