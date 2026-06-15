class CartItemModel {
  final String menuId;
  final String name;
  final double price;
  final int quantity;
  final String image;

  CartItemModel({
    required this.menuId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      menuId: json['menuId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      image: json['image'] ?? '',
    );
  }
}

class CartModel {
  final String id;
  final String restaurantId;
  final List<CartItemModel> items;
  final double totalAmount;

  CartModel({
    required this.id,
    required this.restaurantId,
    required this.items,
    required this.totalAmount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      items: (json['items'] as List? ?? [])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    );
  }
}
