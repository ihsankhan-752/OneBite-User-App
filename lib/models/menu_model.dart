class MenuModel {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final bool isAvailable;
  final RestaurantInfo? restaurantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MenuModel({
    this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.image = '',
    this.category = '',
    this.isAvailable = true,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['_id'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      category: json['category'] as String? ?? '',
      isAvailable: json['isAvailable'] as bool? ?? true,
      restaurantId: json['restaurantId'] is String
          ? RestaurantInfo(
              id: json['restaurantId'] as String,
              name: '',
              location: '',
            )
          : json['restaurantId'] is Map
              ? RestaurantInfo.fromJson(
                  Map<String, dynamic>.from(json['restaurantId']),
                )
              : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id,
    'name': name,
    'description': description,
    'price': price,
    'image': image,
    'category': category,
    'isAvailable': isAvailable,
    'restaurantId': restaurantId?.id,
  };
}

class RestaurantInfo {
  final String id;
  final String name;
  final String location;

  RestaurantInfo({
    required this.id,
    required this.name,
    required this.location,
  });

  factory RestaurantInfo.fromJson(Map<String, dynamic> json) {
    String loc = '';
    if (json['address'] is String) {
      loc = json['address'] as String;
    } else if (json['location'] is String) {
      loc = json['location'] as String;
    } else if (json['location'] is Map) {
      final coords = json['location']['coordinates'];
      if (coords is List) {
        loc = coords.join(', ');
      }
    }

    return RestaurantInfo(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      location: loc,
    );
  }
}
