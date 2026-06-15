import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:onebite_user_app/core/api_constant.dart';
import 'package:onebite_user_app/core/token_storage.dart';
import 'package:onebite_user_app/models/menu_model.dart';

class FavoriteServices {
  final http.Client _client;

  FavoriteServices({http.Client? client}) : _client = client ?? http.Client();

  Future<List<String>> fetchFavorites() async {
    try {
      final token = await TokenStorage.getToken();

      final response = await _client.get(
        Uri.parse("${ApiConstant.baseUrl}/favorite"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["message"] ?? "Failed to fetch favorites");
      }

      final favoriteItems = data["favoriteItems"] as List?;
      if (favoriteItems == null) return [];

      final List<String> menuIds = [];
      for (var item in favoriteItems) {
        if (item is Map) {
          final menuIdField = item["menuId"];
          if (menuIdField is Map && menuIdField["_id"] is String) {
            menuIds.add(menuIdField["_id"] as String);
          } else if (menuIdField is String) {
            menuIds.add(menuIdField);
          }
        }
      }
      return menuIds;
    } on SocketException {
      throw Exception("No Internet");
    } on FormatException {
      throw Exception("Invalid response format");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToFavorite(String menuId) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await _client.post(
        Uri.parse("${ApiConstant.baseUrl}/favorite/$menuId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw Exception(data["message"] ?? "Failed to add to favorites");
      }
    } on SocketException {
      throw Exception("No Internet");
    } on FormatException {
      throw Exception("Invalid response format");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromFavorite(String menuId) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await _client.delete(
        Uri.parse("${ApiConstant.baseUrl}/favorite/$menuId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["message"] ?? "Failed to remove from favorites");
      }
    } on SocketException {
      throw Exception("No Internet");
    } on FormatException {
      throw Exception("Invalid response format");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MenuModel>> fetchFavoriteItem() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await _client.get(
        Uri.parse("${ApiConstant.baseUrl}/favorite"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final menus = data['favoriteItems'];

        if (menus == null || menus is! List) {
          return [];
        }

        return menus
            .where((item) => item['menuId'] != null)
            .map((item) => MenuModel.fromJson(item['menuId']))
            .toList();
      }

      throw Exception(data['message'] ?? "No Item Found in Favorite");
    } on SocketException {
      throw Exception("No Internet Access");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      rethrow;
    }
  }
}
