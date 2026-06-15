import 'package:flutter/cupertino.dart';
import 'package:onebite_user_app/services/auth_services.dart';
import 'dart:convert';

import '../core/token_storage.dart';

class AuthController extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Add userId
  String? _userId;
  String? get userId => _userId;

  String? _userName;
  String? get userName => _userName;

  String? _userEmail;
  String? get userEmail => _userEmail;

  Future<void> loadUser() async {
    final token = await TokenStorage.getToken();
    _isLoggedIn = token != null && token.isNotEmpty;

    if (_isLoggedIn) {
      _userId = await TokenStorage.getUserId();
      _userName = await TokenStorage.getUserName();
      _userEmail = await TokenStorage.getUserEmail();
      
      if ((_userId == null || _userName == null || _userEmail == null) && token != null) {
        try {
          final parts = token.split('.');
          if (parts.length == 3) {
            String payload = parts[1];
            payload = payload.padRight(payload.length + (4 - payload.length % 4) % 4, '=');
            final decoded = utf8.decode(base64Url.decode(payload));
            final data = jsonDecode(decoded);
            
            _userId ??= data['_id'] ?? data['id'] ?? data['userId'];
            _userName ??= data['name'] ?? data['userName'];
            _userEmail ??= data['email'] ?? data['userEmail'];
            
            if (_userId != null) await TokenStorage.saveUserId(_userId!);
            if (_userName != null) await TokenStorage.saveUserName(_userName!);
            if (_userEmail != null) await TokenStorage.saveUserEmail(_userEmail!);
          }
        } catch(e) {
          debugPrint('Error decoding token: $e');
        }
      }
    }

    notifyListeners();
  }

  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty) {
      _errorMessage = "Name required";
      notifyListeners();
      return;
    }
    if (email.isEmpty) {
      _errorMessage = "Email required";
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      _errorMessage = "Password required";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authServices.userSignUp(
        name: name,
        email: email,
        password: password,
      );
      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      _errorMessage = "Email required";
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      _errorMessage = "Password required";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authServices.userLogin(email: email, password: password);
      _isLoggedIn = true;
      _userId = await TokenStorage.getUserId();
      _userName = await TokenStorage.getUserName();
      _userEmail = await TokenStorage.getUserEmail();
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearToken();
    await TokenStorage.clearUserId();
    await TokenStorage.clearUserName();
    await TokenStorage.clearUserEmail();
    _isLoggedIn = false;
    _userId = null;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
