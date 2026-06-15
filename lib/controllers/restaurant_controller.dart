import 'package:flutter/cupertino.dart';

import '../models/restaurant_model.dart';
import '../services/restaurant_services.dart';

class RestaurantController extends ChangeNotifier {
  final RestaurantServices _services = RestaurantServices();
  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> get restaurants => _restaurants;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchRestaurants() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      _restaurants = await _services.fetchRestaurants();
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
