import 'package:flutter/foundation.dart';
import 'package:onebite_user_app/models/review_model.dart';
import 'package:onebite_user_app/services/review_services.dart';

class ReviewController extends ChangeNotifier {
  final ReviewServices _services;

  ReviewController({ReviewServices? services})
    : _services = services ?? ReviewServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;

  final List<String> _reviewedOrderIds = [];
  List<String> get reviewedOrderIds => _reviewedOrderIds;

  Future<bool> addReview({
    required String orderId,
    required String restaurantId,
    required int rating,
    required String review,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _services.addReview(
        orderId: orderId,
        restaurantId: restaurantId,
        rating: rating,
        review: review,
      );
      _reviewedOrderIds.add(orderId);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      if (_errorMessage?.contains("already rate") == true) {
        // If the backend says it's already rated, hide the button for this order too
        _reviewedOrderIds.add(orderId);
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReviews(String restaurantId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _reviews = await _services.getRestaurantReviews(restaurantId);
    } catch (e) {
      _reviews = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
