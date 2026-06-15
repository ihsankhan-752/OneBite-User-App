import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onebite_user_app/models/restaurant_model.dart';

import '../core/api_constant.dart';

class RestaurantServices {
  Future<List<RestaurantModel>> fetchRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/restaurant/approved"),
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final restaurants = data['restaurants'] as List;
        return restaurants.map((e) => RestaurantModel.fromJson(e)).toList();
      }

      throw Exception(data['message'] ?? "Failed to Fetch Restaurants");
    } on SocketException {
      throw Exception("Network Error");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
