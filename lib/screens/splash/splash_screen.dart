import 'package:flutter/material.dart';
import 'package:onebite_user_app/screens/auth/login_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/custom_navbar.dart';
import 'package:onebite_user_app/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authController = context.read<AuthController>();
      final cartController = context.read<CartController>();
      final orderController = context.read<OrderController>();

      await authController.loadUser();

      if (!mounted) return;

      if (authController.isLoggedIn) {
        await cartController.fetchCartItems();

        if (authController.userId != null) {
          orderController.connectSocket(context, authController.userId!);
        }

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CustomNavbar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LogoWidget()],
        ),
      ),
    );
  }
}
