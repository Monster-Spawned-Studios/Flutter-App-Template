// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/theme_provider.dart';
import '../services/logger_service.dart';
import '../widgets/animated_card.dart';
import '../widgets/language_selector.dart';
import 'about_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const SettingsScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_getAppBarTitle()),
      actions: [
        IconButton(
          icon: const Icon(Icons.lock),
          onPressed: () {
            LoggerService.instance.info('Lock button pressed');
            Provider.of<AuthProvider>(context, listen: false).lockApp();
            Navigator.of(context).pushReplacementNamed('/lock');
          },
        ),
      ],
    ),
    body: IndexedStack(index: _selectedIndex, children: _screens),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        LoggerService.instance.info(
          'Tab changed from $_selectedIndex to $index',
        );
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'settings'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: 'about'.tr(),
        ),
      ],
    ),
  );

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'home'.tr();
      case 1:
        return 'settings'.tr();
      case 2:
        return 'about'.tr();
      default:
        return 'app_title'.tr();
    }
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Card
        AnimatedCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This is a comprehensive Flutter template with localization, themes, biometric authentication, and notifications.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // Features Grid
        Text(
          'Features',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

        const SizedBox(height: 12),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _FeatureCard(
              icon: Icons.language,
              title: 'language'.tr(),
              subtitle: 'Multi-language support',
              onTap: () => _showLanguageDialog(context),
            ),
            _FeatureCard(
              icon: Icons.palette,
              title: 'theme'.tr(),
              subtitle: 'Dark/Light themes',
              onTap: () => _showThemeDialog(context),
            ),
            _FeatureCard(
              icon: Icons.fingerprint,
              title: 'biometric_auth'.tr(),
              subtitle: 'Secure authentication',
              onTap: () => _testBiometric(context),
            ),
            _FeatureCard(
              icon: Icons.notifications,
              title: 'notifications'.tr(),
              subtitle: 'Local notifications',
              onTap: () => _testNotification(context),
            ),
          ],
        ),
      ],
    ),
  );

  void _showLanguageDialog(BuildContext context) {
    LoggerService.instance.info('Showing language selector dialog');
    showDialog<void>(
      context: context,
      builder: (context) => const LanguageSelector(),
    );
  }

  void _showThemeDialog(BuildContext context) {
    LoggerService.instance.info('Showing theme selector dialog');
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

  Future<void> _testBiometric(BuildContext context) async {
    LoggerService.instance.info('Testing biometric from home screen');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAvailable = await authProvider.isBiometricAvailable();

    if (!isAvailable) {
      LoggerService.instance.warning('Biometric test failed - not available');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('biometric_not_available'.tr())));
      return;
    }

    final success = await authProvider.authenticateWithBiometric();
    LoggerService.instance.info('Biometric test result: $success');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Authentication successful' : 'biometric_failed'.tr(),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _testNotification(BuildContext context) {
    LoggerService.instance.info('Testing notification from home screen');
    Provider.of<NotificationProvider>(
      context,
      listen: false,
    ).showHelloWorldNotification();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('hello_world_notification'.tr())));
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AnimatedCard(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
