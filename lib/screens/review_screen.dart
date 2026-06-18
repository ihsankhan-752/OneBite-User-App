import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/review_controller.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final String orderId;
  final String restaurantId;

  const ReviewScreen({
    super.key,
    required this.orderId,
    required this.restaurantId,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 0;
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rate Your Order")),
      body: Consumer<ReviewController>(
        builder: (context, reviewController, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "How was your experience?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return GestureDetector(
                      onTap: () => setState(() => _rating = starIndex),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          starIndex <= _rating ? Icons.star : Icons.star_border,
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Write a review (optional)",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF2A2A2A)),
                  ),
                  child: TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Tell us about your experience...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: reviewController.isLoading
                        ? null
                        : () async {
                            if (_rating == 0) {
                              showCustomMsg(context, "Please select a rating");
                              return;
                            }

                            final success = await reviewController.addReview(
                              orderId: widget.orderId,
                              restaurantId: widget.restaurantId,
                              rating: _rating,
                              review: _reviewController.text.trim(),
                            );

                            if (!context.mounted) return;

                            if (success) {
                              showCustomMsg(context, "Review submitted!");
                              Navigator.pop(context);
                            } else if (reviewController.errorMessage != null) {
                              showCustomMsg(
                                context,
                                reviewController.errorMessage!,
                              );
                              reviewController.clearError();
                            }
                          },
                    child: reviewController.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Submit Review",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
