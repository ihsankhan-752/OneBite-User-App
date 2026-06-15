import 'package:flutter/foundation.dart';
import 'package:onebite_user_app/models/menu_model.dart';
import 'package:onebite_user_app/services/favorite_services.dart';

class FavoriteController extends ChangeNotifier {
  final FavoriteServices _services;

  FavoriteController({FavoriteServices? services})
    : _services = services ?? FavoriteServices();

  ///=============This Portion till errorMessage is Related with FavoriteScreen==========///
  List<MenuModel> _favorites = [];
  List<MenuModel> get favorites => _favorites;

  bool _isFavoriteLoading = false;
  bool get isFavoriteLoading => _isFavoriteLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ///============ The below code is related with home screen ===========///
  final Map<String, bool> _loadingMap = {};
  final Map<String, bool> _favoritedMap = {};
  final Map<String, String?> _errorMap = {};
  bool _isFetchingFavorites = false;

  bool isLoading(String menuId) => _loadingMap[menuId] ?? false;
  bool isFavorited(String menuId) => _favoritedMap[menuId] ?? false;
  String? errorMsg(String menuId) => _errorMap[menuId];
  bool get isFetchingFavorites => _isFetchingFavorites;

  Future<void> fetchFavorites() async {
    _isFetchingFavorites = true;
    notifyListeners();

    try {
      final List<String> favoriteIds = await _services.fetchFavorites();
      _favoritedMap.clear();
      for (final id in favoriteIds) {
        _favoritedMap[id] = true;
      }
    } catch (e) {
      debugPrint("Failed to fetch favorites: $e");
    } finally {
      _isFetchingFavorites = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String menuId) async {
    _loadingMap[menuId] = true;
    _errorMap[menuId] = null;
    notifyListeners();

    final alreadyFavorited = _favoritedMap[menuId] ?? false;

    try {
      if (alreadyFavorited) {
        await _services.removeFromFavorite(menuId);
      } else {
        await _services.addToFavorite(menuId);
      }

      _favoritedMap[menuId] = !alreadyFavorited;

      await fetchFavoriteMenus();
    } catch (e) {
      final errorStr = e.toString();
      if (errorStr.contains("Item Already in Favorite")) {
        _favoritedMap[menuId] = true;
      } else if (errorStr.contains("Item not found in Favorite")) {
        _favoritedMap[menuId] = false;
      } else {
        _errorMap[menuId] = errorStr.replaceAll("Exception: ", "");
      }
    } finally {
      _loadingMap[menuId] = false;
      notifyListeners();
    }
  }

  Future<void> fetchFavoriteMenus() async {
    _isFavoriteLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _favorites = await _services.fetchFavoriteItem();
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _isFavoriteLoading = false;
      notifyListeners();
    }
  }
}
