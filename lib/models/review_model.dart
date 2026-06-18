



class ReviewModel {
  final String id;
  final String orderId;
  final String userId;
  final String? userName;
  final String? userEmail;
  final String restaurantId;
  final double rating;
  final String review;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.orderId,
    required this.userId,
    this.userName,
    this.userEmail,
    required this.restaurantId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id']?.toString() ?? '',
      orderId: json['orderId']?.toString() ?? '',
      userId: json['userId'] is Map
          ? json['userId']['_id']?.toString() ?? ''
          : json['userId']?.toString() ?? '',
      userName: json['userId'] is Map ? json['userId']['name']?.toString() : null,
      userEmail: json['userId'] is Map ? json['userId']['email']?.toString() : null,
      restaurantId: json['restaurantId']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      review: json['review']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}