import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart'; // ✅ TO'G'RI - barcha Get features
import 'package:grand_hotel/repositories/card_repository.dart';
import 'package:grand_hotel/repositories/local_message_repository.dart';

import 'bloc/app_starter/app_starter_bloc.dart';
import 'bloc/app_starter/app_starter_state.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/best_today/best_today_bloc.dart';
import 'bloc/best_today/best_today_event.dart';
import 'bloc/booking/booking_bloc.dart';
import 'bloc/card/card_bloc.dart';
import 'bloc/card/card_event.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/language/language_event.dart';
import 'bloc/language/language_state.dart';
import 'bloc/message/message_bloc.dart';
import 'bloc/message/message_event.dart';
import 'bloc/most_popular/most_popular_bloc.dart';
import 'bloc/most_popular/most_popular_event.dart';
import 'bloc/nearby_hotels/nearby_hotels_bloc.dart';
import 'bloc/nearby_hotels/nearby_hotels_event.dart';
import 'bloc/payment/payment_method_bloc.dart';
import 'bloc/recommended/recommended_bloc.dart';
import 'bloc/recommended/recommended_event.dart';
import 'bloc/search_hotel/search_hotels_bloc.dart';
import 'bloc/search_hotel/search_hotels_event.dart';
import 'data/languages/app_localizations.dart';
import 'main_screen.dart';
import 'models/payment_card.dart';

class CardRepositoryImpl implements CardRepository {
  @override
  Future<List<PaymentCard>> getCards() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      PaymentCard(
        id: '1',
        cardType: 'VISA',
        balance: '\$3,242.23',
        cardNumber: '9865 3567 4563 4235',
        expiryDate: '12/24',
        startColor: '0xFF5B57D4',
        endColor: '0xFF7B78E8',
        logoAsset: 'VISA',
        isDefault: true,
      ),
      PaymentCard(
        id: '2',
        cardType: 'Mastercard',
        balance: '\$4,570.80',
        cardNumber: '5294 2436 4780 9568',
        expiryDate: '12/24',
        startColor: '0xFF1E1E1E',
        endColor: '0xFF2D2D2D',
        logoAsset: 'Mastercard',
        isDefault: false,
      ),
    ];
  }

  @override
  Future<void> addCard(PaymentCard card) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> deleteCard(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> setDefaultCard(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final messageRepository = LocalMessageRepository();
  await messageRepository.init();

  final cardRepository = CardRepositoryImpl();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(
    messageRepository: messageRepository,
    cardRepository: cardRepository,
  ));
}

class MyApp extends StatelessWidget {
  final LocalMessageRepository messageRepository;
  final CardRepositoryImpl cardRepository;

  const MyApp({
    super.key,
    required this.messageRepository,
    required this.cardRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppStarterBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => LanguageBloc()..add(LoadSavedLanguage()),
        ),
        BlocProvider(
          create: (context) => MostPopularBloc()..add(LoadMostPopularHotels()),
        ),
        BlocProvider(
          create: (context) =>
          RecommendedBloc()..add(LoadRecommendedProperties()),
        ),
        BlocProvider(
          create: (context) => NearbyHotelsBloc()..add(LoadNearbyHotels()),
        ),
        BlocProvider(
          create: (context) => BestTodayBloc()..add(LoadBestTodayHotels()),
        ),
        BlocProvider(
          create: (context) => SearchHotelsBloc()..add(LoadSearchHotels()),
        ),
        BlocProvider(
          create: (context) =>
          PaymentMethodBloc()..add(LoadPaymentMethods()),
        ),
        BlocProvider(
          create: (context) => BookingBloc()..add(LoadBookings()),
        ),
        BlocProvider(
          create: (context) =>
          MessageBloc(repository: messageRepository)..add(LoadMessages()),
        ),
        BlocProvider(
          create: (context) =>
          CardBloc(cardRepository: cardRepository)..add(LoadCards()),
        ),
      ],
      child: BlocBuilder<AppStarterBloc, AppStarterState>(
        builder: (context, appState) {
          Future.delayed(const Duration(milliseconds: 100), () {
            FlutterNativeSplash.remove();
          });

          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return GetMaterialApp(
                title: 'Grand Hotel',
                debugShowCheckedModeBanner: false,
                locale: languageState.locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                  Locale('uz'),
                  Locale('id'),
                  Locale('zh'),
                  Locale('hr'),
                  Locale('cs'),
                  Locale('da'),
                  Locale('fil'),
                  Locale('fi'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode ==
                        languageState.locale.languageCode) {
                      return languageState.locale;
                    }
                  }
                  return const Locale('en');
                },
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  useMaterial3: true,
                  brightness: appState is AppStarterInitialized &&
                      appState.isDarkMode
                      ? Brightness.dark
                      : Brightness.light,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
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
                themeMode: appState is AppStarterInitialized &&
                    appState.isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const MainScreen(),
                defaultTransition: Transition.cupertino, // ✅ Endi ishlaydi
                transitionDuration: const Duration(milliseconds: 300),
              );
            },
          );
        },
      ),
    );
  }
}