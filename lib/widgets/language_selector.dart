// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text('language'.tr()),
    content: Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: localeProvider.supportedLocales.map((locale) {
          final isSelected = localeProvider.currentLocale == locale;

          return GestureDetector(
            onTap: () {
              localeProvider.setLocale(locale);
              context.setLocale(locale);
              Navigator.of(context).pop();
            },
            child: Container(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              child: ListTile(
                leading: Icon(
                  Icons.language,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  localeProvider.getLanguageName(locale),
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  locale.languageCode.toUpperCase(),
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withOpacity(0.7)
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
            ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.3, end: 0),
          );
        }).toList(),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Close'),
      ),
    ],
  );
}
