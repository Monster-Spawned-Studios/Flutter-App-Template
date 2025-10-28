// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/lock_screen.dart';
import 'screens/splash_screen.dart';
import 'services/logger_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Logger Service
  await LoggerService.instance.initialize();
  LoggerService.instance.info('App initialization started');

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();
  LoggerService.instance.info('EasyLocalization initialized');

  LoggerService.instance.info('Starting FlutterTemplateApp');

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('fr', 'FR'),
        Locale('de', 'DE'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const FlutterTemplateApp(),
    ),
  );
}

class FlutterTemplateApp extends StatelessWidget {
  const FlutterTemplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    LoggerService.instance.debug('Creating provider tree');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'app_title'.tr(),
          debugShowCheckedModeBanner: false,

          // Localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Theme
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,

          // Routes
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/lock': (context) => const LockScreen(),
          },

          // Animations
          builder: (context, child) =>
              child?.animate().fadeIn(duration: 300.ms) ?? child!,
        ),
      ),
    );
  }
}
