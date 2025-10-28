// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/animated_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'about'.tr(),
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // App Info Card
        AnimatedCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.flutter_dash,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'app_title'.tr(),
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Version 1.0.0',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A comprehensive Flutter app template with CI/CD, localization, security, and best practices.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
            .animate(delay: 100.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // Features List
        Text(
          'Features',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

        const SizedBox(height: 12),

        ..._buildFeatureItems(context),

        const SizedBox(height: 16),

        // Company Info
        Text(
          'Monster Spawned Studios',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

        const SizedBox(height: 12),

        AnimatedCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Copyright © 2025 Monster Spawned Studios',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'https://monsterspawned.studio/',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'All rights reserved.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
            .animate(delay: 400.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.3, end: 0),
      ],
    ),
  );

  List<Widget> _buildFeatureItems(BuildContext context) {
    final features = [
      {
        'icon': Icons.language,
        'title': 'Multi-language Support',
        'desc': 'English, Spanish, French, German',
      },
      {
        'icon': Icons.palette,
        'title': 'Theme Support',
        'desc': 'Light, Dark, and System themes',
      },
      {
        'icon': Icons.fingerprint,
        'title': 'Biometric Authentication',
        'desc': 'Secure fingerprint/face unlock',
      },
      {
        'icon': Icons.notifications,
        'title': 'Local Notifications',
        'desc': 'Push notification system',
      },
      {
        'icon': Icons.security,
        'title': 'Security Features',
        'desc': 'PIN lock and secure storage',
      },
      {
        'icon': Icons.animation,
        'title': 'Smooth Animations',
        'desc': 'Beautiful UI transitions',
      },
      {
        'icon': Icons.build,
        'title': 'CI/CD Ready',
        'desc': 'GitHub Actions for iOS/Android builds',
      },
      {
        'icon': Icons.code,
        'title': 'Code Quality',
        'desc': 'Pre-commit hooks and linting',
      },
    ];

    return features.asMap().entries.map((entry) {
      final index = entry.key;
      final feature = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child:
            AnimatedCard(
                  child: ListTile(
                    leading: Icon(
                      feature['icon']! as IconData,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      feature['title']! as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      feature['desc']! as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                )
                .animate(delay: (500 + index * 50).ms)
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.3, end: 0),
      );
    }).toList();
  }
}
