import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onebite_user_app/models/menu_model.dart';

import '../core/api_constant.dart';

class MenuService {
  Future<List<MenuModel>> fetchMenus() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/menu/all"),
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final menus = data['menus'] as List;
        return menus.map((e) => MenuModel.fromJson(e)).toList();
      }

      throw Exception(data['message'] ?? "Failed to fetch menus");
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
