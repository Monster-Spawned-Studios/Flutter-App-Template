// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/theme_provider.dart';
import '../services/logger_service.dart';
import '../widgets/animated_card.dart';
import '../widgets/language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings'.tr(),
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // Language Settings
        AnimatedCard(
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Text('language'.tr()),
                subtitle: Text(_getCurrentLanguage(context)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showLanguageDialog(context),
              ),
            )
            .animate(delay: 100.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 8),

        // Theme Settings
        AnimatedCard(
              child: ListTile(
                leading: const Icon(Icons.palette),
                title: Text('theme'.tr()),
                subtitle: Text(_getCurrentTheme(context)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showThemeDialog(context),
              ),
            )
            .animate(delay: 200.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 8),

        // Biometric Settings
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) =>
              AnimatedCard(
                    child: SwitchListTile(
                      secondary: const Icon(Icons.fingerprint),
                      title: Text('biometric_auth'.tr()),
                      subtitle: const Text('Enable biometric authentication'),
                      value: authProvider.isBiometricEnabled,
                      onChanged: (value) => _toggleBiometric(context, value),
                    ),
                  )
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.3, end: 0),
        ),

        const SizedBox(height: 8),

        // Notification Settings
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, _) =>
              AnimatedCard(
                    child: SwitchListTile(
                      secondary: const Icon(Icons.notifications),
                      title: Text('notifications'.tr()),
                      subtitle: const Text('Enable notifications'),
                      value: notificationProvider.isPermissionGranted,
                      onChanged: (value) =>
                          _toggleNotifications(context, value),
                    ),
                  )
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.3, end: 0),
        ),

        const SizedBox(height: 8),

        // Lock Screen Settings
        AnimatedCard(
              child: ListTile(
                leading: const Icon(Icons.lock),
                title: Text('lock_screen'.tr()),
                subtitle: const Text('Set up PIN or biometric lock'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showLockSetupDialog(context),
              ),
            )
            .animate(delay: 500.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 8),

        // Clear Data
        AnimatedCard(
              child: ListTile(
                leading: const Icon(Icons.clear_all, color: Colors.red),
                title: const Text(
                  'Clear All Data',
                  style: TextStyle(color: Colors.red),
                ),
                subtitle: const Text('Reset all settings and data'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showClearDataDialog(context),
              ),
            )
            .animate(delay: 600.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),
      ],
    ),
  );

  String _getCurrentLanguage(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return localeProvider.getLanguageName(localeProvider.currentLocale);
  }

  String _getCurrentTheme(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (themeProvider.isDarkMode) return 'dark_theme'.tr();
    if (themeProvider.isLightMode) return 'light_theme'.tr();
    return 'system_theme'.tr();
  }

  void _showLanguageDialog(BuildContext context) {
    LoggerService.instance.info(
      'Showing language selector dialog from settings',
    );
    showDialog<void>(
      context: context,
      builder: (context) => const LanguageSelector(),
    );
  }

  void _showThemeDialog(BuildContext context) {
    LoggerService.instance.info('Showing theme selector dialog from settings');
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('theme'.tr()),
        content: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('light_theme'.tr()),
                trailing: Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: themeProvider.themeMode,
                  onChanged: (mode) {
                    themeProvider.setThemeMode(mode!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('dark_theme'.tr()),
                trailing: Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: themeProvider.themeMode,
                  onChanged: (mode) {
                    themeProvider.setThemeMode(mode!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('system_theme'.tr()),
                trailing: Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: themeProvider.themeMode,
                  onChanged: (mode) {
                    themeProvider.setThemeMode(mode!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleBiometric(BuildContext context, bool value) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.enableBiometric(value);
      LoggerService.instance.info(
        'Biometric ${value ? 'enabled' : 'disabled'}',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value ? 'Biometric enabled' : 'Biometric disabled'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      LoggerService.instance.error('Failed to toggle biometric', error: e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _toggleNotifications(BuildContext context, bool value) {
    LoggerService.instance.info(
      'Notifications ${value ? 'enabled' : 'disabled'}',
    );
    // This would typically request notification permission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? 'Notifications enabled' : 'Notifications disabled',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showLockSetupDialog(BuildContext context) {
    LoggerService.instance.info('Showing lock screen setup dialog');
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('lock_screen'.tr()),
        content: const Text('Lock screen setup would be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    LoggerService.instance.warning('Showing clear data confirmation dialog');
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'Are you sure you want to clear all data? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearAllData(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAllData(BuildContext context) async {
    LoggerService.instance.warning('Clearing all application data');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.clearAuth();

    LoggerService.instance.info('All data cleared successfully');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All data cleared'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
