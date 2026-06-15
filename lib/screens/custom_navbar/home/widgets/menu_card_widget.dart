import 'package:flutter/material.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/menu_detail_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/favorite_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/place_holder_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/menu_model.dart';

class MenuCardWidget extends StatelessWidget {
  final MenuModel menu;

  const MenuCardWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MenuDetailScreen(menu: menu)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: menu.image.isNotEmpty
                  ? Image.network(
                      menu.image,
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => placeHolderWidget(),
                    )
                  : placeHolderWidget(),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.restaurantId?.name ?? 'Restaurant',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    menu.name,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (menu.description.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      menu.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (menu.category.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            menu.category,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(width: 4),
                      Text(
                        'RS ${menu.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            FavoriteWidget(menu: menu),
          ],
        ),
      ),
    );
  }
}
