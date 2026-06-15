import 'package:flutter/material.dart';
import 'package:onebite_user_app/controllers/cart_controller.dart';
import 'package:onebite_user_app/controllers/favorite_controller.dart';
import 'package:onebite_user_app/screens/custom_navbar/widgets/badge_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/widgets/bottom_tab_widget.dart';
import 'package:onebite_user_app/utils/lists.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabWidget(
              title: "Home",
              icon: Icons.home_filled,
              isActive: _currentIndex == 0,
              activeColor: _currentIndex == 0
                  ? AppColors.primaryColor
                  : Colors.white54,
              onPressed: () => setState(() => _currentIndex = 0),
            ),

            BottomTabWidget(
              title: "Orders",
              icon: Icons.shopping_bag_outlined,
              isActive: _currentIndex == 1,
              activeColor: _currentIndex == 1
                  ? AppColors.primaryColor
                  : Colors.white54,
              onPressed: () => setState(() => _currentIndex = 1),
            ),

            GestureDetector(
              onTap: () => setState(() => _currentIndex = 2),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: _currentIndex == 2
                            ? AppColors.primaryColor
                            : Colors.white54,
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: _currentIndex == 2
                          ? AppColors.primaryColor
                          : Colors.white54,
                      size: 26,
                    ),
                  ),

                  Selector<CartController, int>(
                    selector: (_, c) => c.totalItemsCount,
                    builder: (_, count, __) {
                      if (count == 0) return const SizedBox.shrink();
                      return Positioned(
                        top: 4,
                        right: 4,
                        child: BadgeWidget(count: count),
                      );
                    },
                  ),
                ],
              ),
            ),

            Selector<FavoriteController, int>(
              selector: (_, c) => c.favorites.length,
              builder: (_, count, __) {
                return BottomTabWidget(
                  title: "Favorites",
                  icon: Icons.favorite_border,
                  isActive: _currentIndex == 3,
                  activeColor: _currentIndex == 3
                      ? AppColors.primaryColor
                      : Colors.white54,
                  badgeCount: count,
                  onPressed: () => setState(() => _currentIndex = 3),
                );
              },
            ),

            BottomTabWidget(
              title: "Profile",
              icon: Icons.person_outline_rounded,
              isActive: _currentIndex == 4,
              activeColor: _currentIndex == 4
                  ? AppColors.primaryColor
                  : Colors.white54,
              onPressed: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
