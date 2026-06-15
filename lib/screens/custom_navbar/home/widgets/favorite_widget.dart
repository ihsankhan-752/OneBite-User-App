import 'package:flutter/material.dart';
import 'package:onebite_user_app/models/menu_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/favorite_controller.dart';
import '../../../../utils/custom_msg.dart';

class FavoriteWidget extends StatelessWidget {
  final MenuModel menu;
  const FavoriteWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteController>(
      builder: (context, favoriteController, _) {
        final loading = favoriteController.isLoading(menu.id!);
        final favorited = favoriteController.isFavorited(menu.id!);

        return Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: GestureDetector(
            onTap: loading
                ? null
                : () async {
                    await favoriteController.toggleFavorite(menu.id!);

                    final error = favoriteController.errorMsg(menu.id!);
                    if (error != null) {
                      if (!context.mounted) return;
                      showCustomMsg(context, error);
                    }
                  },
            child: loading
                ? const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFFFF6B00),
                    ),
                  )
                : Icon(
                    favorited ? Icons.favorite : Icons.favorite_border,
                    color: favorited
                        ? Colors.redAccent
                        : AppColors.primaryColor,
                    size: 25,
                  ),
          ),
        );
      },
    );
  }
}
