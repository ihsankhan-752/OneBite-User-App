import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/order_model.dart';
import '../order_detail_screen.dart';
import 'order_status_badge.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;

  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #${order.id.substring(order.id.length - 6).toUpperCase()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OrderStatusBadge(status: order.orderStatus),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.white54,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  "${order.items.length} item${order.items.length > 1 ? 's' : ''}",
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.payment_outlined,
                  color: Colors.white54,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  order.paymentMethod == "cash" ? "Cash on Delivery" : "Stripe",
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Divider(color: Color(0xFF2A2A2A)),
            const SizedBox(height: 10),

            // Date + Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(order.createdAt),
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                Text(
                  "Rs ${order.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
