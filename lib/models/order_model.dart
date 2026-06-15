class OrderItemModel {
  final String menuId;
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderItemModel({
    required this.menuId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      menuId: json['menuId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      image: json['image'] ?? '',
    );
  }
}

class OrderModel {
  final String id;
  final String restaurantId;
  final List<OrderItemModel> items;
  final double totalAmount;
  final double deliveryFee;
  final String orderStatus;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.restaurantId,
    required this.items,
    required this.totalAmount,
    required this.deliveryFee,
    required this.orderStatus,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryAddress,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      items: (json['items'] as List? ?? [])
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      orderStatus: json['orderStatus'] ?? 'pending',
      paymentMethod: json['paymentMethod'] ?? 'cash',
      paymentStatus: json['paymentStatus'] ?? 'pending',
      deliveryAddress: json['deliveryAddress'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
