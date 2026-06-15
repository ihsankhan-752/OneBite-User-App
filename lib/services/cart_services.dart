import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onebite_user_app/models/cart_model.dart';

import '../core/api_constant.dart';
import '../core/token_storage.dart';

class CartServices {
  final http.Client _client;

  CartServices({http.Client? client}) : _client = client ?? http.Client();

  Future<CartModel> addToCart({
    required String menuId,
    required String restaurantId,
    required String name,
    required double price,
    required String image,
    int quantity = 1,
  }) async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.post(
        Uri.parse("${ApiConstant.baseUrl}/cart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "menuId": menuId,
          "restaurantId": restaurantId,
          "name": name,
          "price": price,
          "image": image,
          "quantity": quantity,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return CartModel.fromJson(data['cart']);
      }

      throw Exception(data['message'] ?? "Failed to add item to cart");
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> getCartItems() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.get(
        Uri.parse("${ApiConstant.baseUrl}/cart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final carts = data['cart'] as List? ?? [];
        return carts.map((cart) => CartModel.fromJson(cart)).toList();
      }

      throw Exception(data['message'] ?? "Failed to fetch cart items");
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromCart({
    required String cartId,
    required String menuId,
  }) async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.delete(
        Uri.parse("${ApiConstant.baseUrl}/cart/$cartId/$menuId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data['message'] ?? "Failed to remove item from cart");
      }
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }
}
