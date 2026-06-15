import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onebite_user_app/controllers/auth_controller.dart';
import 'package:onebite_user_app/controllers/banner_controller.dart';
import 'package:onebite_user_app/controllers/cart_controller.dart';
import 'package:onebite_user_app/controllers/favorite_controller.dart';
import 'package:onebite_user_app/controllers/menu_controller.dart';
import 'package:onebite_user_app/controllers/order_controller.dart';
import 'package:onebite_user_app/controllers/restaurant_controller.dart';
import 'package:onebite_user_app/core/keys.dart';
import 'package:onebite_user_app/screens/splash/splash_screen.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = stripePublishKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => RestaurantController()),
        ChangeNotifierProvider(create: (_) => RestaurantMenuController()),
        ChangeNotifierProvider(create: (_) => BannerController()),
        ChangeNotifierProvider(create: (_) => FavoriteController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: MaterialApp(
        title: 'OneBite User App',
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.appBg,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.primaryColor),
            backgroundColor: AppColors.appBg,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
