class BannerModel {
  final String id;
  final String image;
  final String title;
  final String discount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  BannerModel({
    required this.id,
    required this.image,
    this.title = '',
    this.discount = '',
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      discount: json['discount'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'discount': discount,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  BannerModel copyWith({
    String? id,
    String? image,
    String? title,
    String? discount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      discount: discount ?? this.discount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'BannerModel(id: $id, image: $image, title: $title, '
        'discount: $discount, isActive: $isActive, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
