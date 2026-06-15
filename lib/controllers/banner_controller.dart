import 'package:flutter/foundation.dart';
import 'package:onebite_user_app/models/banner_model.dart';
import 'package:onebite_user_app/services/banner_services.dart';

class BannerController extends ChangeNotifier {
  final BannerServices _services = BannerServices();
  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;
  bool _isLoading = false;
  String? _errorMsg;

  bool get isLoading => _isLoading;
  String? get errorMsg => _errorMsg;

  Future<void> fetchBanners() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();
    try {
      _banners = await _services.fetchBanners();
    } catch (e) {
      _errorMsg = e.toString().replaceAll("Exception:", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
