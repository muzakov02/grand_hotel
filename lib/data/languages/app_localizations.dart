import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'home': 'Home',
      'search': 'Search',
      'bookings': 'Bookings',
      'messages': 'Messages',
      'profile': 'Profile',
      'language': 'Language',
      'suggested_languages': 'Suggested Languages',
      'other_languages': 'Other Languages',
      'most_popular': 'Most Popular',
      'recommended': 'Recommended',
      'nearby_hotels': 'Nearby Hotels',
      'best_today': 'Best Today',
      'settings': 'Settings',
      'logout': 'Logout',
      'notifications': 'Notifications',
      'privacy': 'Privacy',
      'terms': 'Terms & Conditions',
      'help': 'Help & Support',
      'about': 'About',
    },
    'ru': {
      'home': 'Главная',
      'search': 'Поиск',
      'bookings': 'Бронирования',
      'messages': 'Сообщения',
      'profile': 'Профиль',
      'language': 'Язык',
      'suggested_languages': 'Рекомендуемые языки',
      'other_languages': 'Другие языки',
      'most_popular': 'Самые популярные',
      'recommended': 'Рекомендуемые',
      'nearby_hotels': 'Отели поблизости',
      'best_today': 'Лучшие сегодня',
      'settings': 'Настройки',
      'logout': 'Выйти',
      'notifications': 'Уведомления',
      'privacy': 'Конфиденциальность',
      'terms': 'Условия использования',
      'help': 'Помощь и поддержка',
      'about': 'О приложении',
    },
    'uz': {
      'home': 'Bosh sahifa',
      'search': 'Qidiruv',
      'bookings': 'Bandlovlar',
      'messages': 'Xabarlar',
      'profile': 'Profil',
      'language': 'Til',
      'suggested_languages': 'Tavsiya etilgan tillar',
      'other_languages': 'Boshqa tillar',
      'most_popular': 'Eng mashhur',
      'recommended': 'Tavsiya etilgan',
      'nearby_hotels': 'Yaqin atrofdagi mehmonxonalar',
      'best_today': 'Bugungi eng yaxshisi',
      'settings': 'Sozlamalar',
      'logout': 'Chiqish',
      'notifications': 'Bildirishnomalar',
      'privacy': 'Maxfiylik',
      'terms': 'Foydalanish shartlari',
      'help': 'Yordam va qo\'llab-quvvatlash',
      'about': 'Ilova haqida',
    },
    'id': {
      'home': 'Beranda',
      'search': 'Cari',
      'bookings': 'Pesanan',
      'messages': 'Pesan',
      'profile': 'Profil',
      'language': 'Bahasa',
      'suggested_languages': 'Bahasa yang Disarankan',
      'other_languages': 'Bahasa Lainnya',
      'most_popular': 'Paling Populer',
      'recommended': 'Direkomendasikan',
      'nearby_hotels': 'Hotel Terdekat',
      'best_today': 'Terbaik Hari Ini',
      'settings': 'Pengaturan',
      'logout': 'Keluar',
      'notifications': 'Notifikasi',
      'privacy': 'Privasi',
      'terms': 'Syarat & Ketentuan',
      'help': 'Bantuan & Dukungan',
      'about': 'Tentang',
    },
    'zh': {
      'home': '主页',
      'search': '搜索',
      'bookings': '预订',
      'messages': '消息',
      'profile': '个人资料',
      'language': '语言',
      'suggested_languages': '建议语言',
      'other_languages': '其他语言',
      'most_popular': '最受欢迎',
      'recommended': '推荐',
      'nearby_hotels': '附近酒店',
      'best_today': '今日最佳',
      'settings': '设置',
      'logout': '登出',
      'notifications': '通知',
      'privacy': '隐私',
      'terms': '条款和条件',
      'help': '帮助与支持',
      'about': '关于',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getter methods for easier access
  String get home => translate('home');
  String get search => translate('search');
  String get bookings => translate('bookings');
  String get messages => translate('messages');
  String get profile => translate('profile');
  String get language => translate('language');
  String get suggestedLanguages => translate('suggested_languages');
  String get otherLanguages => translate('other_languages');
  String get mostPopular => translate('most_popular');
  String get recommended => translate('recommended');
  String get nearbyHotels => translate('nearby_hotels');
  String get bestToday => translate('best_today');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'uz', 'id', 'zh', 'hr', 'cs', 'da', 'fil', 'fi']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Extension for easy usage
extension LocalizationExtension on BuildContext {
  AppLocalizations get loc =>
      AppLocalizations.of(this) ?? AppLocalizations(const Locale('en'));
}