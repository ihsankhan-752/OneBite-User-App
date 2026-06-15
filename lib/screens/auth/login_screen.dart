import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/controllers/auth_controller.dart';
import 'package:onebite_user_app/controllers/order_controller.dart';
import 'package:onebite_user_app/screens/auth/create_account_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/custom_navbar.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:onebite_user_app/widgets/buttons.dart';
import 'package:onebite_user_app/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/text_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              LogoWidget(),

              const SizedBox(height: 56),

              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Sign in to continue ordering',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 36),

              CustomTextInput(
                controller: _emailController,
                label: 'Email address',
                hint: 'you@example.com',
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),

              CustomTextInput(
                controller: _passwordController,
                label: 'Password',
                hint: '••••••••',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF555555),
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              Consumer<AuthController>(
                builder: (context, authController, child) {
                  return PrimaryButton(
                    title: authController.isLoading
                        ? "Please Wait...."
                        : "Login",
                    onPressed: () async {
                      await authController.userLogin(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (!context.mounted) return;

                      if (authController.errorMessage != null &&
                          authController.errorMessage!.isNotEmpty) {
                        showCustomMsg(
                          context,
                          authController.errorMessage!,
                          bgColor: Colors.red,
                        );

                        return;
                      }

                      if (authController.userId != null) {
                        context.read<OrderController>().connectSocket(context, authController.userId!);
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => CustomNavbar()),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateAccountScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
