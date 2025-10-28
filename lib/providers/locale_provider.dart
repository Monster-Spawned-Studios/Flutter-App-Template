// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/logger_service.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider() {
    _loadLocale();
    // Logger will be initialized after main() completes
    Future.microtask(
      () => LoggerService.instance.info('LocaleProvider initialized'),
    );
  }
  static const String _localeKey = 'selected_locale';

  Locale _currentLocale = const Locale('en', 'US');

  Locale get currentLocale => _currentLocale;

  final List<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
  ];

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey) ?? 'en_US';
    final parts = localeCode.split('_');
    if (parts.length == 2) {
      _currentLocale = Locale(parts[0], parts[1]);
    } else {
      _currentLocale = const Locale('en', 'US');
    }
    notifyListeners();
    LoggerService.instance.debug('Locale loaded: $_currentLocale');
  }

  Future<void> setLocale(Locale locale) async {
    if (supportedLocales.contains(locale)) {
      LoggerService.instance.info(
        'Changing locale to: ${locale.languageCode}_${locale.countryCode}',
      );
      _currentLocale = locale;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _localeKey,
        '${locale.languageCode}_${locale.countryCode}',
      );
      notifyListeners();
    } else {
      LoggerService.instance.warning(
        'Attempted to set unsupported locale: $locale',
      );
    }
  }

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      default:
        return locale.languageCode;
    }
  }
}
