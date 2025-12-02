import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_event.dart';
import 'language_state.dart';
import 'package:flutter/material.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState.initial()) {
    on<LoadSavedLanguage>(_onLoadSavedLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  // Language mapping
  static const Map<String, Map<String, String>> languageMap = {
    'English': {'code': 'en', 'country': ''},
    'Русский': {'code': 'ru', 'country': ''},
    'O\'zbek': {'code': 'uz', 'country': ''},
    'Bahasa Indonesia': {'code': 'id', 'country': ''},
    '中文': {'code': 'zh', 'country': ''},
    'Hrvatski': {'code': 'hr', 'country': ''},
    'Čeština': {'code': 'cs', 'country': ''},
    'Dansk': {'code': 'da', 'country': ''},
    'Filipino': {'code': 'fil', 'country': ''},
    'Suomi': {'code': 'fi', 'country': ''},
  };

  Future<void> _onLoadSavedLanguage(
      LoadSavedLanguage event,
      Emitter<LanguageState> emit,
      ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('selected_language') ?? 'English';

      final langData = languageMap[savedLanguage];
      if (langData != null) {
        final locale = langData['country']!.isNotEmpty
            ? Locale(langData['code']!, langData['country'])
            : Locale(langData['code']!);

        emit(LanguageState(
          locale: locale,
          displayName: savedLanguage,
        ));
      }
    } catch (e) {
      print('Error loading saved language: $e');
    }
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event,
      Emitter<LanguageState> emit,
      ) async {
    try {
      final locale = event.countryCode != null && event.countryCode!.isNotEmpty
          ? Locale(event.languageCode, event.countryCode)
          : Locale(event.languageCode);

      // Find display name
      String displayName = 'English';
      languageMap.forEach((key, value) {
        if (value['code'] == event.languageCode &&
            value['country'] == (event.countryCode ?? '')) {
          displayName = key;
        }
      });

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', displayName);

      // Debug
      print('🌍 Language changed to: $displayName (${locale.languageCode})');
      print('📱 Saved to SharedPreferences: $displayName');

      emit(state.copyWith(
        locale: locale,
        displayName: displayName,
      ));

      print('✅ State emitted successfully');
    } catch (e) {
      print('❌ Error changing language: $e');
    }
  }
}