import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/favorite_controller.dart';
import 'package:onebite_user_app/screens/custom_navbar/favorite/widgets/favorite_card_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/favorite/widgets/no_favorite_item_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteController>().fetchFavoriteMenus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "Favorites",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<FavoriteController>(
              builder: (context, favoriteController, _) {
                if (favoriteController.isFavoriteLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                if (favoriteController.errorMessage != null &&
                    favoriteController.errorMessage!.isNotEmpty) {
                  return Center(
                    child: Text(
                      favoriteController.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }

                if (favoriteController.favorites.isEmpty) {
                  return Center(child: NoFavoriteItemWidget());
                }

                return ListView.builder(
                  itemCount: favoriteController.favorites.length,
                  itemBuilder: (context, index) {
                    final menu = favoriteController.favorites[index];
                    return FavoriteCardWidget(menu: menu);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
