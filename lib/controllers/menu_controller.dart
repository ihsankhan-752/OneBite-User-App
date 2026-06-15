import 'package:flutter/material.dart';
import 'package:onebite_user_app/models/menu_model.dart';

import '../services/menu_services.dart';

class RestaurantMenuController extends ChangeNotifier {
  final MenuService _menuService = MenuService();

  List<MenuModel> _menus = [];
  bool _isLoading = false;
  String? _error;

  List<MenuModel> get menus => _menus;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, List<MenuModel>> get groupedMenus {
    final Map<String, List<MenuModel>> grouped = {};
    for (final menu in _menus) {
      final key = menu.restaurantId?.id ?? 'unknown';
      grouped.putIfAbsent(key, () => []).add(menu);
    }
    return grouped;
  }

  Future<void> fetchMenus() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _menus = await _menuService.fetchMenus();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
