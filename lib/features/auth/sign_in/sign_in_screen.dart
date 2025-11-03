// features/auth/views/screens/sign_in_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/bloc/auth/auth_bloc.dart';
import 'package:grand_hotel/bloc/auth/auth_event.dart';
import 'package:grand_hotel/bloc/auth/auth_state.dart';
import 'package:grand_hotel/core/common/utils/validation_untils.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/core/routes/app_routers.dart';
import 'package:grand_hotel/features/auth/sign_up/sign_up_screen.dart';
import 'package:grand_hotel/features/auth/views/screens/forgot_password_screen.dart';
import 'package:grand_hotel/features/auth/views/widgets/custom_text_field.dart';
import 'package:grand_hotel/features/auth/views/widgets/social_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  String? emailError;
  String? passwordError;

  void validateInputs() {
    setState(() {
      emailError = ValidationUtils.validateEmail(emailController.text);
      passwordError = ValidationUtils.validatePassword(passwordController.text);
    });
  }

  bool get isValid => emailError == null && passwordError == null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Login successful - navigate to home
            Get.offAllNamed(AppRouters.home);
          } else if (state is AuthError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Lets Sign you in',
                      textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          color: isDark ? Colors.white : AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
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
                const SizedBox(height: 40),

                // Email
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: emailError,
                  onChanged: (value) => validateInputs(),
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

                // Password
                CustomTextField(
                  label: 'Password',
                  hintText: 'Create a password',
                  controller: passwordController,
                  isPassword: true,
                  errorText: passwordError,
                  onChanged: (value) => validateInputs(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Remember me + Forgot Password
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: rememberMe,
                        shape: const CircleBorder(),
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xFFE3E9ED), width: 1),
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sign In button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return CustomButton(
                      text: 'Sign In',
                      onPressed: isValid && !isLoading
                          ? () {
                        context.read<AuthBloc>().add(
                          SignInUser(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            rememberMe: rememberMe,
                          ),
                        );
                      }
                          : null,
                      isLoading: isLoading,
                      isDisabled: !isValid || isLoading,
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // OR divider
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: isDark
                                ? Colors.white38
                                : Colors.grey.shade400)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Or Sign In with'),
                    ),
                    Expanded(
                        child: Divider(
                            color: isDark
                                ? Colors.white38
                                : Colors.grey.shade400)),
                  ],
                ),
                const SizedBox(height: 24),

                // Social buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialButton(
                        icon: 'assets/images/google.png', onPressed: () {}),
                    SocialButton(
                        icon: 'assets/images/apple.png', onPressed: () {}),
                    SocialButton(
                        icon: 'assets/images/facebook.png', onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 30),

                // Terms
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("By signing up you agree to our",
                        style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.textLight)),
                    const SizedBox(width: 4),
                    const Text('Terms',
                        style: TextStyle(
                            color: Color(0xFF171725),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("and",
                        style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : AppColors.textLight)),
                    const SizedBox(width: 4),
                    const Text('Conditions of Use',
                        style: TextStyle(
                            color: Color(0xFF171725),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}