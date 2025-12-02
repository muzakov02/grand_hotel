abstract class LanguageEvent {}

class LoadSavedLanguage extends LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;
  final String? countryCode;

  ChangeLanguage(this.languageCode, {this.countryCode});
}