// bloc/app_starter/app_starter_state.dart
abstract class AppStarterState {}

class AppStarterInitial extends AppStarterState {}

class AppStarterInitializing extends AppStarterState {}

class AppStarterInitialized extends AppStarterState {
  final bool isDarkMode;
  final String languageCode;

  AppStarterInitialized({
    this.isDarkMode = false,
    this.languageCode = 'en',
  });

  AppStarterInitialized copyWith({
    bool? isDarkMode,
    String? languageCode,
  }) {
    return AppStarterInitialized(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

class AppStarterError extends AppStarterState {
  final String message;

  AppStarterError(this.message);
}