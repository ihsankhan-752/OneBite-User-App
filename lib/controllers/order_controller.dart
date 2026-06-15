import 'package:flutter/material.dart';
import 'package:onebite_user_app/models/order_model.dart';
import 'package:onebite_user_app/services/order_services.dart';
import 'package:onebite_user_app/widgets/status_dialog.dart';

import '../core/stripe_payment_handler.dart';
import '../services/socket_service.dart';

class OrderController extends ChangeNotifier {
  final OrderServices _services;

  OrderController({OrderServices? services})
    : _services = services ?? OrderServices();

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> placeOrders({
    required List<String> restaurantIds,
    required String deliveryAddress,
    required String paymentMethod,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _services.placeOrders(
        restaurantIds: restaurantIds,
        deliveryAddress: deliveryAddress,
        paymentMethod: paymentMethod,
      );

      if (!context.mounted) return;

      if (paymentMethod == "stripe" && result['clientSecret'] != null) {
        await stripePaymentHandler(
          clientSecret: result['clientSecret'],
          context: context,
        );
      }
      _orders.insertAll(0, result['orders']);
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Function(String)? onOrderStatusUpdate;

  void connectSocket(BuildContext context, String userId) {
    SocketService.connect(userId);
    print("Socket Connected: $userId");

    SocketService.onOrderStatusUpdate((data) {
      debugPrint("Order status update: $data");

      final orderId = data['orderId'].toString();
      final newStatus = data['orderStatus'].toString();

      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = OrderModel(
          id: _orders[index].id,
          restaurantId: _orders[index].restaurantId,
          items: _orders[index].items,
          totalAmount: _orders[index].totalAmount,
          deliveryFee: _orders[index].deliveryFee,
          orderStatus: newStatus,
          paymentMethod: _orders[index].paymentMethod,
          paymentStatus: _orders[index].paymentStatus,
          deliveryAddress: _orders[index].deliveryAddress,
          createdAt: _orders[index].createdAt,
        );
        notifyListeners();
      }

      // Show beautiful dialog box
      final String messageStr = data['message']?.toString() ?? "Order status changed to $newStatus";
      showOrderStatusDialog(
        title: "Order Update",
        message: messageStr,
        status: newStatus,
      );

      onOrderStatusUpdate?.call(messageStr);
    });
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _services.getOrders();
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
