import 'package:flutter/material.dart';
import 'package:onebite_user_app/screens/custom_navbar/orders/widgets/order_item_tile.dart';
import 'package:onebite_user_app/screens/custom_navbar/orders/widgets/order_status_badge.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/order_controller.dart';
import '../../../models/order_model.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderController = context.watch<OrderController>();
    final currentOrder = orderController.orders.firstWhere(
      (o) => o.id == order.id,
      orElse: () => order,
    );

    const deliveryFee = 200.0;
    const tax = 0.08;
    final taxAmount = currentOrder.totalAmount * tax;
    final total = currentOrder.totalAmount + deliveryFee + taxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order #${currentOrder.id.substring(currentOrder.id.length - 6).toUpperCase()}",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ===== Status =====
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OrderStatusBadge(status: currentOrder.orderStatus),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    currentOrder.deliveryAddress,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ===== Items =====
          const Text(
            "Items",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...currentOrder.items.map((item) => OrderItemTile(item: item)),
          const SizedBox(height: 16),

          Container(
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
                  "Payment Summary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _summaryRow(
                  "Subtotal",
                  "Rs ${currentOrder.totalAmount.toStringAsFixed(2)}",
                ),
                const SizedBox(height: 8),
                _summaryRow(
                  "Delivery Fee",
                  "Rs ${deliveryFee.toStringAsFixed(2)}",
                ),
                const SizedBox(height: 8),
                _summaryRow("Tax & Fees", "Rs ${taxAmount.toStringAsFixed(2)}"),
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
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment Method",
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    Text(
                      currentOrder.paymentMethod == "cash"
                          ? "Cash on Delivery"
                          : "Stripe",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment Status",
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    Text(
                      currentOrder.paymentStatus.toUpperCase(),
                      style: TextStyle(
                        color: currentOrder.paymentStatus == "paid"
                            ? Colors.green
                            : Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
