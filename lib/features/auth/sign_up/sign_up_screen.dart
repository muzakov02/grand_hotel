import 'package:flutter/material.dart';
import 'package:grand_hotel/core/common/utils/validation_untils.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/auth/views/widgets/custom_text_field.dart';
import 'package:grand_hotel/features/auth/views/widgets/social_button.dart';
import 'package:grand_hotel/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String selectRole = 'customer';
  String? emailError;
  String? passwordError;

  void validateInputs() {
    setState(() {
      emailError = ValidationUtils.validateEmail(emailController.text);
      passwordError = ValidationUtils.validatePassword(passwordController.text);
    });
  }

  bool get isValid =>
      emailError == null &&
      passwordError == null &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              color: isDark ? Colors.white : AppColors.textDark,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? const Color(0xFF434E58)
                                : AppColors.textLight,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Full Name',
                hintText: 'Enter your full name',
                controller: nameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError,
                onChanged: (value) {
                  validateInputs();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hintText: 'Create a password',
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                errorText: passwordError,
                onChanged: (value) {
                  validateInputs();
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Create An Account',
                onPressed: () {
                  if (!isValid) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                isLoading: isLoading,
                isDisabled: !isValid,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or Sign In with',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SocialButton(
                    icon: 'assets/images/google.png',
                    onPressed: () {},
                  ),
                  SocialButton(
                    icon: 'assets/images/apple.png',
                    onPressed: () {},
                  ),
                  SocialButton(
                    icon: 'assets/images/facebook.png',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By signing up you agree to our",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Terms',
                    style: TextStyle(
                      color: Color(0xFF171725),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "and",
                    style: TextStyle(
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Conditions of Use',
                    style: TextStyle(
                      color: Color(0xFF171725),
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
