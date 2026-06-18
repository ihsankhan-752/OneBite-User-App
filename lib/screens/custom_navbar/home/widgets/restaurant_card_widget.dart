import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/models/restaurant_model.dart';
import 'package:onebite_user_app/services/review_services.dart' as onebite_review_service;

class RestaurantCardWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCardWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlack.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(16),
            //     bottomLeft: Radius.circular(16),
            //   ),
            //   child: Image.network(
            //     restaurant.logo ?? "https://via.placeholder.com/100",
            //     width: 100,
            //     height: 100,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      restaurant.address,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        FutureBuilder<List<dynamic>>(
                          future: onebite_review_service.ReviewServices()
                              .getRestaurantReviews(restaurant.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    restaurant.averageRating.toStringAsFixed(1),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 6),
                                  const SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.grey,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ],
                              );
                            }
                            
                            final reviews = snapshot.data ?? [];
                            final count = reviews.length;
                            double avgRating = restaurant.averageRating;
                            
                            if (count > 0) {
                              double sum = 0;
                              for (var r in reviews) {
                                sum += r.rating;
                              }
                              avgRating = sum / count;
                            }

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  avgRating.toStringAsFixed(1),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "($count Reviews)",
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "• ${restaurant.cuisineDisplay.isNotEmpty ? restaurant.cuisineDisplay : "Fast Food"}",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
