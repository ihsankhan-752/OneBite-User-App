class RestaurantModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String logo;
  final String address;
  final bool isApproved;
  final GeoLocation location;
  final List<String> cuisine;
  final double averageRating;
  final bool isOpen;
  final String openingHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  RestaurantModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.logo = '',
    required this.address,
    this.isApproved = false,
    required this.location,
    this.cuisine = const [],
    this.averageRating = 0,
    this.isOpen = true,
    this.openingHours = '',
    required this.createdAt,
    required this.updatedAt,
  });

  String get approvalStatus => isApproved ? 'Approved' : 'Pending';
  String get cuisineDisplay => cuisine.join(', ');

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'] ?? '',
      userId: json['userId'] is Map
          ? json['userId']['_id'] ?? ''
          : json['userId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      address: json['address'] ?? '',
      isApproved: json['isApproved'] ?? false,
      location: GeoLocation.fromJson(json['location'] ?? {}),
      cuisine: List<String>.from(json['cuisine'] ?? []),
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      isOpen: json['isOpen'] ?? true,
      openingHours: json['openingHours'] ?? '',
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'logo': logo,
      'address': address,
      'isApproved': isApproved,
      'location': location.toJson(),
      'cuisine': cuisine,
      'averageRating': averageRating,
      'isOpen': isOpen,
      'openingHours': openingHours,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  RestaurantModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? logo,
    String? address,
    bool? isApproved,
    GeoLocation? location,
    List<String>? cuisine,
    double? averageRating,
    bool? isOpen,
    String? openingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      address: address ?? this.address,
      isApproved: isApproved ?? this.isApproved,
      location: location ?? this.location,
      cuisine: cuisine ?? this.cuisine,
      averageRating: averageRating ?? this.averageRating,
      isOpen: isOpen ?? this.isOpen,
      openingHours: openingHours ?? this.openingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class GeoLocation {
  final String type;
  final double longitude;
  final double latitude;

  const GeoLocation({
    this.type = 'Point',
    this.longitude = 0,
    this.latitude = 0,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    final coords = json['coordinates'] as List<dynamic>? ?? [0, 0];
    return GeoLocation(
      type: json['type'] ?? 'Point',
      longitude: (coords[0] ?? 0).toDouble(),
      latitude: (coords[1] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': [longitude, latitude],
    };
  }
}
