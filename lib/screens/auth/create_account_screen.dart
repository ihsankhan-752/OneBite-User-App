import 'package:flutter/material.dart';
import 'package:onebite_user_app/controllers/auth_controller.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';
import 'package:onebite_user_app/widgets/buttons.dart';
import 'package:onebite_user_app/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../widgets/text_inputs.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
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
      backgroundColor: const Color(0xFF0A0A0A),
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
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 20),

              CustomTextInput(
                controller: _nameController,
                label: 'Name',
                hint: 'John Doe',
                prefixIcon: Icons.person_outline_rounded,
                onChanged: (val) {},
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

              const SizedBox(height: 36),

              Consumer<AuthController>(
                builder: (context, authController, child) {
                  return PrimaryButton(
                    title: authController.isLoading
                        ? "Please Wait...."
                        : "Create Account",
                    onPressed: () async {
                      await authController.userSignUp(
                        name: _nameController.text,
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
                      showCustomMsg(context, "Account Created!");
                    },
                  );
                },
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
