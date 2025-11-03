// core/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:grand_hotel/core/routes/app_routers.dart';
import 'package:grand_hotel/features/auth/sign_in/sign_in_screen.dart';
import 'package:grand_hotel/features/auth/sign_up/sign_up_screen.dart';
import 'package:grand_hotel/features/auth/views/screens/forgot_password_screen.dart';
import 'package:grand_hotel/main_screen.dart';

import '../../features/onboarding/screens/onboarding_screen.dart';

class AppPages {
  // Barcha route'larni ro'yxati
  static final routes = [
    // Onboarding
    GetPage(
      name: AppRouters.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Sign In
    GetPage(
      name: AppRouters.signIn,
      page: () => const SignInScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Sign Up
    GetPage(
      name: AppRouters.signUp,
      page: () => const SignUpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Forgot Password
    GetPage(
      name: AppRouters.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Home (Main Screen)
    GetPage(
      name: AppRouters.home,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}