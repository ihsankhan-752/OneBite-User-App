import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onebite_user_app/models/order_model.dart';

import '../core/api_constant.dart';
import '../core/token_storage.dart';

class OrderServices {
  final http.Client _client;

  OrderServices({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> placeOrders({
    required List<String> restaurantIds,
    required String deliveryAddress,
    required double deliveryLat,
    required double deliveryLng,
    required String paymentMethod,
  }) async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.post(
        Uri.parse("${ApiConstant.baseUrl}/orders"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "restaurantIds": restaurantIds,
          "deliveryAddress": deliveryAddress,
          "deliveryLat": deliveryLat,
          "deliveryLng": deliveryLng,
          "paymentMethod": paymentMethod,
        }),
      );

      debugPrint("Place orders response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final orders = (data['orders'] as List? ?? [])
            .map((o) => OrderModel.fromJson(o))
            .toList();

        return {"orders": orders, "clientSecret": data['clientSecret']};
      }

      throw Exception(data['message'] ?? "Failed to place orders");
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.get(
        Uri.parse("${ApiConstant.baseUrl}/orders"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("Get orders response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final orders = data['orders'] as List? ?? [];
        return orders.map((o) => OrderModel.fromJson(o)).toList();
      }

      throw Exception(data['message'] ?? "Failed to fetch orders");
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }
}
