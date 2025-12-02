import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;
  final String displayName;

  LanguageState({
    required this.locale,
    required this.displayName,
  });

  factory LanguageState.initial() {
    return LanguageState(
      locale: const Locale('en'),
      displayName: 'English',
    );
  }

  LanguageState copyWith({
    Locale? locale,
    String? displayName,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
      displayName: displayName ?? this.displayName,
    );
  }
}