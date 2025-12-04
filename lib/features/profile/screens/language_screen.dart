import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/language/language_bloc.dart';
import 'package:grand_hotel/bloc/language/language_event.dart';
import 'package:grand_hotel/bloc/language/language_state.dart';
import 'package:grand_hotel/data/languages/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<String> suggestedLanguages = ['English', 'Русский', 'O\'zbek'];

  final List<String> otherLanguages = [
    'Bahasa Indonesia',
    '中文',
    'Hrvatski',
    'Čeština',
    'Dansk',
    'Filipino',
    'Suomi'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.loc.language),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.suggestedLanguages,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...suggestedLanguages.asMap().entries.map((entry) {
                        int index = entry.key;
                        String lang = entry.value;
                        bool isLast = index == suggestedLanguages.length - 1;
                        return _buildLanguageOption(
                          lang,
                          isLast,
                          languageState.displayName,
                          context,
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.otherLanguages,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...otherLanguages.asMap().entries.map((entry) {
                        int index = entry.key;
                        String lang = entry.value;
                        bool isLast = index == otherLanguages.length - 1;
                        return _buildLanguageOption(
                          lang,
                          isLast,
                          languageState.displayName,
                          context,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    String language,
    bool isLast,
    String currentLanguage,
    BuildContext context,
  ) {
    final bool isSelected = currentLanguage == language;

    return InkWell(
      onTap: () {
        // Language mapping
        final languageMap = LanguageBloc.languageMap[language];
        if (languageMap != null) {
          context.read<LanguageBloc>().add(
                ChangeLanguage(
                  languageMap['code']!,
                  countryCode: languageMap['country']!.isNotEmpty
                      ? languageMap['country']
                      : null,
                ),
              );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check,
                    color: Color(0xFF2853AF),
                    size: 20,
                  ),
              ],
            ),
            if (!isLast) ...[
              const SizedBox(height: 12),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                height: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
