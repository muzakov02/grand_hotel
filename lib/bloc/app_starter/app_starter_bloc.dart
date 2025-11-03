// bloc/app_starter/app_starter_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_starter_event.dart';
import 'app_starter_state.dart';

class AppStarterBloc extends Bloc<AppStarterEvent, AppStarterState> {
  AppStarterBloc() : super(AppStarterInitial()) {
    on<InitializeApp>(_onInitializeApp);
    on<ChangeTheme>(_onChangeTheme);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onInitializeApp(
      InitializeApp event,
      Emitter<AppStarterState> emit,
      ) async {
    emit(AppStarterInitializing());

    try {
      // Simulate initialization delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Load saved preferences
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool('isDarkMode') ?? false;
      final languageCode = prefs.getString('languageCode') ?? 'en';

      emit(AppStarterInitialized(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ));
    } catch (e) {
      emit(AppStarterError(e.toString()));
    }
  }

  Future<void> _onChangeTheme(
      ChangeTheme event,
      Emitter<AppStarterState> emit,
      ) async {
    if (state is AppStarterInitialized) {
      final currentState = state as AppStarterInitialized;

      try {
        // Save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isDarkMode', event.isDark);

        emit(currentState.copyWith(isDarkMode: event.isDark));
      } catch (e) {
        emit(AppStarterError(e.toString()));
      }
    }
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event,
      Emitter<AppStarterState> emit,
      ) async {
    if (state is AppStarterInitialized) {
      final currentState = state as AppStarterInitialized;

      try {
        // Save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('languageCode', event.languageCode);

        emit(currentState.copyWith(languageCode: event.languageCode));
      } catch (e) {
        emit(AppStarterError(e.toString()));
      }
    }
  }
}