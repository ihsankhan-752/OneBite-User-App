import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:onebite_user_app/core/api_constant.dart';
import 'package:onebite_user_app/models/banner_model.dart';

class BannerServices {
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstant.baseUrl}/banner"),
        headers: {"Content-Type": "application/json"},
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final banners = data['banners'] as List;
        return banners.map((e) => BannerModel.fromJson(e)).toList();
      }

      throw Exception("No Banners Found");
    } on SocketException {
      throw Exception("No Internet Access");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
