import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/bloc/app_starter/app_starter_bloc.dart';
import 'package:grand_hotel/bloc/app_starter/app_starter_state.dart';
import 'package:grand_hotel/bloc/auth/auth_bloc.dart';
import 'package:grand_hotel/bloc/most_popular/most_popular_bloc.dart';
import 'package:grand_hotel/bloc/most_popular/most_popular_event.dart';
import 'package:grand_hotel/bloc/recommended/recommended_bloc.dart';
import 'package:grand_hotel/bloc/recommended/recommended_event.dart';
import 'package:grand_hotel/bloc/nearby_hotels/nearby_hotels_bloc.dart';
import 'package:grand_hotel/bloc/nearby_hotels/nearby_hotels_event.dart';
import 'package:grand_hotel/bloc/best_today/best_today_bloc.dart';
import 'package:grand_hotel/bloc/best_today/best_today_event.dart';
import 'package:grand_hotel/bloc/reviews/reviews_bloc.dart';
import 'package:grand_hotel/core/routes/app_pages.dart';
import 'package:grand_hotel/features/home/screens/home_screen.dart';

import 'bloc/reviews/reviews_event.dart';
import 'bloc/search_hotel/search_hotels_bloc.dart';
import 'bloc/search_hotel/search_hotels_event.dart';

void main() {
  // Flutter binding'ni initialize qilish
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Native splash screenni saqlab qolish
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // System UI sozlamalari (status bar va navigation bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar transparent
      statusBarIconBrightness: Brightness.light, // Oq ikonkalar
      statusBarBrightness: Brightness.dark, // iOS uchun
      systemNavigationBarColor: Colors.white, // Navigation bar rangi
      systemNavigationBarIconBrightness: Brightness.dark, // Qora ikonkalar
    ),
  );

  // Preferred orientations (ixtiyoriy)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // App Starter BLoC
        BlocProvider(
          create: (context) => AppStarterBloc(),
        ),

        // Auth BLoC
        BlocProvider(
          create: (context) => AuthBloc(),
        ),

        // Most Popular BLoC
        BlocProvider(
          create: (context) => MostPopularBloc()..add(LoadMostPopularHotels()),
        ),

        // Recommended BLoC
        BlocProvider(
          create: (context) => RecommendedBloc()..add(LoadRecommendedProperties()),
        ),

        // Nearby Hotels BLoC
        BlocProvider(
          create: (context) => NearbyHotelsBloc()..add(LoadNearbyHotels()),
        ),

        // Best Today BLoC
        BlocProvider(
          create: (context) => BestTodayBloc()..add(LoadBestTodayHotels()),
        ),
    BlocProvider(
    create: (context) => SearchHotelsBloc()..add(LoadSearchHotels()),
    ),

      ],
      child: BlocBuilder<AppStarterBloc, AppStarterState>(
        builder: (context, state) {
          // Native splash screenni olib tashlash
          // (AppStarter yuklangandan keyin)
          Future.delayed(const Duration(milliseconds: 100), () {
            FlutterNativeSplash.remove();
          });

          return GetMaterialApp(
            title: 'Grand Hotel',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              brightness: state is AppStarterInitialized && state.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
              // Qo'shimcha theme sozlamalari
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            themeMode: state is AppStarterInitialized && state.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            getPages: AppPages.routes,
            home: const HomeScreen(),
            // Transition animatsiyalari
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}