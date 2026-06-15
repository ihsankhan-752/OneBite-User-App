import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/favorite_widget.dart';

import '../../../../models/menu_model.dart';

class FavoriteCardWidget extends StatelessWidget {
  final MenuModel menu;

  const FavoriteCardWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      margin: const EdgeInsets.only(bottom: 10, right: 16, left: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A2A)),
        image: DecorationImage(
          image: NetworkImage(menu.image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.primaryBlack.withValues(alpha: 0.6),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: FavoriteWidget(menu: menu),
          ),
          Spacer(),

          Text(
            menu.restaurantId?.name ?? 'Restaurant',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            menu.name,
            style: TextStyle(
              color: AppColors.primaryWhite,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
