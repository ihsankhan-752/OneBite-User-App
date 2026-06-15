import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: "jwt", value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "jwt");
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: "jwt");
  }


  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: "userId", value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: "userId");
  }

  static Future<void> clearUserId() async {
    await _storage.delete(key: "userId");
  }

  static Future<void> saveUserName(String name) async {
    await _storage.write(key: "userName", value: name);
  }

  static Future<String?> getUserName() async {
    return await _storage.read(key: "userName");
  }

  static Future<void> clearUserName() async {
    await _storage.delete(key: "userName");
  }

  static Future<void> saveUserEmail(String email) async {
    await _storage.write(key: "userEmail", value: email);
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(key: "userEmail");
  }

  static Future<void> clearUserEmail() async {
    await _storage.delete(key: "userEmail");
  }
}
