import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/core/common/utils/text_scale_wrapper.dart';
import 'package:grand_hotel/core/config/theme/app_theme.dart';
import 'package:grand_hotel/core/controllers/theme_controllers.dart';
import 'package:grand_hotel/core/routes/app_routers.dart';
import 'package:grand_hotel/features/auth/sign_in/blog/sign_in_blog.dart';
import 'package:grand_hotel/features/auth/sign_up/blog/sign_up_blog.dart';
import 'package:grand_hotel/features/onboarding/controller/onboarding_controller.dart';
import 'package:grand_hotel/features/splash/controllers/splash_controller.dart';

// Auth Bloc


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async => ThemeController());
  Get.put(SplashController());
  Get.put(OnboardingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (_) => SignInBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (_) => SignUpBloc(),
        ),
      ],
      child: TextScaleWrapper(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grand Hotel - Hotel Booking App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          themeMode: ThemeController.to.themeMode,
          initialRoute: AppRouters.splash,
          getPages: AppRouters.routers,
        ),
      ),
    );
  }
}
