// bloc/app_starter/app_starter_event.dart
abstract class AppStarterEvent {}

class InitializeApp extends AppStarterEvent {}

class ChangeTheme extends AppStarterEvent {
  final bool isDark;

  ChangeTheme(this.isDark);
}

class ChangeLanguage extends AppStarterEvent {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}