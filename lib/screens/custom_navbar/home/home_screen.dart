import 'package:flutter/material.dart' hide MenuController;
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/menu_controller.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/banner_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/error_view_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/header_widget.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/widgets/menu_card_widget.dart';
import 'package:onebite_user_app/widgets/loading_widget.dart';
import 'package:onebite_user_app/widgets/text_inputs.dart';
import 'package:provider/provider.dart';

import '../../../controllers/banner_controller.dart';
import 'package:onebite_user_app/controllers/favorite_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantMenuController>().fetchMenus();
      context.read<BannerController>().fetchBanners();
      context.read<FavoriteController>().fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            HomeSearchInput(),
            Expanded(
              child: Consumer<RestaurantMenuController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return LoadingWidget();
                  }

                  if (controller.error != null) {
                    return ErrorViewWidget(
                      error: controller.error!,
                      onPressed: () => controller.fetchMenus(),
                    );
                  }

                  if (controller.menus.isEmpty) {
                    return const Center(
                      child: Text(
                        'No menus available',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: const Color(0xFFFF6B00),
                    backgroundColor: const Color(0xFF1A1A1A),
                    onRefresh: controller.fetchMenus,
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                        Consumer<BannerController>(
                          builder: (context, bannerController, _) {
                            if (bannerController.isLoading) {
                              return const SizedBox(
                                height: 150,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFF6B00),
                                  ),
                                ),
                              );
                            }

                            if (bannerController.banners.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return BannerWidget(
                              banners: bannerController.banners,
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Text(
                            "Top Restaurant",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...controller.menus.map((menu) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MenuCardWidget(menu: menu),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
