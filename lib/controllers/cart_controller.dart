import 'package:flutter/foundation.dart';
import 'package:onebite_user_app/models/cart_model.dart';
import 'package:onebite_user_app/services/cart_services.dart';

class CartController extends ChangeNotifier {
  final CartServices _services;

  CartController({CartServices? services})
    : _services = services ?? CartServices();

  // ========== State ==========

  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Map<String, bool> _addingMap = {};
  bool isAdding(String menuId) => _addingMap[menuId] ?? false;

  final Map<String, bool> _removingMap = {};
  bool isRemoving(String menuId) => _removingMap[menuId] ?? false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ========== Computed Getters ==========

  int get totalItemsCount =>
      _carts.fold(0, (sum, cart) => sum + cart.items.length);

  double get grandTotal =>
      _carts.fold(0.0, (sum, cart) => sum + cart.totalAmount);

  int getItemQuantity(String menuId) {
    for (final cart in _carts) {
      final item = cart.items.where((i) => i.menuId == menuId).firstOrNull;
      if (item != null) return item.quantity;
    }
    return 0;
  }

  String? getCartIdByRestaurant(String restaurantId) {
    final cart = _carts
        .where((c) => c.restaurantId == restaurantId)
        .firstOrNull;
    return cart?.id;
  }

  // ========== Fetch Cart ==========

  Future<void> fetchCartItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _carts = await _services.getCartItems();
      debugPrint("Cart loaded: ${_carts.length} carts");
      for (final cart in _carts) {
        debugPrint(
          "Cart items: ${cart.items.length}, total: ${cart.totalAmount}",
        );
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      debugPrint("Cart error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ========== Add To Cart ==========

  Future<void> addToCart({
    required String menuId,
    required String restaurantId,
    required String name,
    required double price,
    required String image,
    int quantity = 1,
  }) async {
    _addingMap[menuId] = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedCart = await _services.addToCart(
        menuId: menuId,
        restaurantId: restaurantId,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
      );

      final index = _carts.indexWhere(
        (cart) => cart.restaurantId == updatedCart.restaurantId,
      );

      if (index != -1) {
        _carts[index] = updatedCart;
      } else {
        _carts.add(updatedCart);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _addingMap[menuId] = false;
      notifyListeners();
    }
  }

  // ========== Decrement Item ==========

  Future<void> decrementItem({
    required String cartId,
    required String menuId,
  }) async {
    _removingMap[menuId] = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final cart = _carts.firstWhere((c) => c.id == cartId);
      final item = cart.items.firstWhere((i) => i.menuId == menuId);

      if (item.quantity == 1) {
        await _services.removeFromCart(cartId: cartId, menuId: menuId);
      } else {
        await _services.addToCart(
          menuId: menuId,
          restaurantId: cart.restaurantId,
          name: item.name,
          price: item.price,
          image: item.image,
          quantity: -1,
        );
      }

      for (int i = 0; i < _carts.length; i++) {
        if (_carts[i].id == cartId) {
          if (item.quantity == 1) {
            // Remove item entirely
            final updatedItems = _carts[i].items
                .where((it) => it.menuId != menuId)
                .toList();

            if (updatedItems.isEmpty) {
              _carts.removeAt(i);
            } else {
              _carts[i] = CartModel(
                id: _carts[i].id,
                restaurantId: _carts[i].restaurantId,
                items: updatedItems,
                totalAmount: updatedItems.fold(
                  0.0,
                  (sum, it) => sum + it.price * it.quantity,
                ),
              );
            }
          } else {
            // Reduce quantity by 1
            final updatedItems = _carts[i].items.map((it) {
              if (it.menuId == menuId) {
                return CartItemModel(
                  menuId: it.menuId,
                  name: it.name,
                  price: it.price,
                  quantity: it.quantity - 1,
                  image: it.image,
                );
              }
              return it;
            }).toList();

            _carts[i] = CartModel(
              id: _carts[i].id,
              restaurantId: _carts[i].restaurantId,
              items: updatedItems,
              totalAmount: updatedItems.fold(
                0.0,
                (sum, it) => sum + it.price * it.quantity,
              ),
            );
          }
          break;
        }
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _removingMap[menuId] = false;
      notifyListeners();
    }
  }

  // ========== Remove From Cart ==========

  Future<void> removeFromCart({
    required String cartId,
    required String menuId,
  }) async {
    _removingMap[menuId] = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _services.removeFromCart(cartId: cartId, menuId: menuId);

      for (int i = 0; i < _carts.length; i++) {
        if (_carts[i].id == cartId) {
          final updatedItems = _carts[i].items
              .where((item) => item.menuId != menuId)
              .toList();

          if (updatedItems.isEmpty) {
            _carts.removeAt(i);
          } else {
            _carts[i] = CartModel(
              id: _carts[i].id,
              restaurantId: _carts[i].restaurantId,
              items: updatedItems,
              totalAmount: updatedItems.fold(
                0.0,
                (sum, item) => sum + item.price * item.quantity,
              ),
            );
          }
          break;
        }
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _removingMap[menuId] = false;
      notifyListeners();
    }
  }

  void clearCart() {
    _carts.clear();
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
