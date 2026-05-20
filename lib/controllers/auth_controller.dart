import 'package:flutter/cupertino.dart';
import 'package:onebite_user_app/services/auth_services.dart';

class AuthController extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  bool isLoading = false;
  String? errorMessage;

  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty) {
      errorMessage = "name required";
      notifyListeners();
      return;
    }
    if (email.isEmpty) {
      errorMessage = "Email required";
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      errorMessage = "Password required";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _authServices.userSignUp(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      errorMessage = "Email required";
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      errorMessage = "Password required";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _authServices.userLogin(email: email, password: password);
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
