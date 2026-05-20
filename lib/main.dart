import 'package:flutter/material.dart';
import 'package:onebite_user_app/controllers/auth_controller.dart';
import 'package:onebite_user_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthController())],
      child: MaterialApp(
        title: 'OneBite User App',

        theme: ThemeData(scaffoldBackgroundColor: AppColors.appBg),
        home: SplashScreen(),
      ),
    );
  }
}
