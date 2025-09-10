

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:grand_hotel/features/auth/sign_in/sign_in_screen.dart';
import 'package:grand_hotel/features/onboarding/screens/onboarding_screen.dart';
import 'package:grand_hotel/features/splash/screens/splash_screen.dart';

class AppRouters{
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';

  static final routers = [
    GetPage(name: splash, page: ()=> const SplashScreen()),
    GetPage(name: onboarding, page: ()=> const OnboardingScreen()),
    GetPage(name: signIn, page: ()=> const SignInScreen()),
  ];
}