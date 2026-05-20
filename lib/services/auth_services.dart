import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onebite_user_app/core/api_constant.dart';
import 'package:onebite_user_app/core/token_storage.dart';

class AuthServices {
  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final String url = "${ApiConstant.baseUrl}/user/signup";

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw Exception(data['message'] ?? "Registration Failed");
      }
    } on SocketException {
      Future.delayed(Duration(seconds: 7), () {
        throw Exception("No internet connection");
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("${ApiConstant.baseUrl}/user/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw Exception(data['message'] ?? "Failed to Login");
      }

      final token = data['token'];

      if (token == null) {
        throw Exception("Token Empty");
      }
      await TokenStorage.saveToken(token);
    } on SocketException {
      throw Exception("No Internet Connection!");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
