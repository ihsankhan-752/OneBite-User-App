import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onebite_user_app/models/review_model.dart';

import '../core/api_constant.dart';
import '../core/token_storage.dart';

class ReviewServices {
  final http.Client _client;

  ReviewServices({http.Client? client}) : _client = client ?? http.Client();

  Future<void> addReview({
    required String orderId,
    required String restaurantId,
    required int rating,
    required String review,
  }) async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.post(
        Uri.parse("${ApiConstant.baseUrl}/review/$orderId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "restaurantId": restaurantId,
          "rating": rating,
          "review": review,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw Exception(data['message'] ?? "Failed to submit review");
      }
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReviewModel>> getRestaurantReviews(String restaurantId) async {
    try {
      final response = await _client.get(
        Uri.parse("${ApiConstant.baseUrl}/review/$restaurantId"),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final reviews = data['reviews'] as List? ?? [];
        return reviews.map((r) => ReviewModel.fromJson(r)).toList();
      }

      return [];
    } on SocketException {
      throw Exception("No Internet Access");
    } catch (e) {
      print("Error fetching reviews: $e");
      return [];
    }
  }
}
