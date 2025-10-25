# Localization Guide

This guide explains how to add and manage multiple languages in the Flutter Template project.

## Overview

The template uses `easy_localization` package for internationalization (i18n) support. Currently supports:

- English (en_US)
- Spanish (es_ES)
- French (fr_FR)
- German (de_DE)

## Project Structure

```
assets/
└── translations/
    ├── en.json    # English translations
    ├── es.json    # Spanish translations
    ├── fr.json    # French translations
    └── de.json    # German translations
```

## Adding a New Language

### 1. Create Translation File

Create a new JSON file in `assets/translations/` directory:

```json
// assets/translations/it.json (Italian example)
{
  "app_title": "Modello Flutter",
  "welcome": "Benvenuto nel Modello Flutter",
  "home": "Casa",
  "settings": "Impostazioni",
  "about": "Informazioni",
  "language": "Lingua",
  "theme": "Tema",
  "light_theme": "Tema Chiaro",
  "dark_theme": "Tema Scuro",
  "system_theme": "Tema Sistema",
  "notifications": "Notifiche",
  "biometric_auth": "Autenticazione Biometrica",
  "lock_screen": "Schermo di Blocco",
  "hello_world_notification": "Ciao, Mondo!",
  "notification_title": "Modello Flutter",
  "notification_body": "Questa è una notifica di esempio del Modello Flutter",
  "unlock_app": "Sblocca App",
  "use_biometric": "Usa Biometrico",
  "use_pin": "Usa PIN",
  "enter_pin": "Inserisci PIN",
  "pin_incorrect": "PIN errato",
  "biometric_failed": "Autenticazione biometrica fallita",
  "biometric_not_available": "Autenticazione biometrica non disponibile",
  "permission_required": "Permesso Richiesto",
  "biometric_permission_denied": "Permesso biometrico negato",
  "enable_notifications": "Abilita Notifiche",
  "notification_permission_denied": "Permesso notifica negato"
}
```

### 2. Update Supported Locales

Update `lib/main.dart` to include the new locale:

```dart
// lib/main.dart
EasyLocalization(
  supportedLocales: const [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('it', 'IT'), // Add new locale
  ],
  path: 'assets/translations',
  fallbackLocale: const Locale('en', 'US'),
  child: const FlutterTemplateApp(),
)
```

### 3. Update LocaleProvider

Update `lib/providers/locale_provider.dart`:

```dart
// lib/providers/locale_provider.dart
final List<Locale> supportedLocales = const [
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('fr', 'FR'),
  Locale('de', 'DE'),
  Locale('it', 'IT'), // Add new locale
];

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
    case 'it':
      return 'Italiano'; // Add new language name
    default:
      return locale.languageCode;
  }
}
```

### 4. Update pubspec.yaml

Ensure the new translation file is included in assets:

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/translations/
```

## Using Translations

### Basic Usage

```dart
// In any widget
Text('app_title'.tr())

// With parameters
Text('welcome_user'.tr(namedArgs: {'name': 'John'}))
```

### Translation with Parameters

Update translation files to include parameters:

```json
// en.json
{
  "welcome_user": "Welcome, {name}!"
}

// es.json
{
  "welcome_user": "¡Bienvenido, {name}!"
}
```

Usage:

```dart
Text('welcome_user'.tr(namedArgs: {'name': 'John'}))
```

### Pluralization

For plural forms, use the `plural` method:

```json
// en.json
{
  "item_count": "{count, plural, =0{No items} =1{One item} other{{count} items}}"
}
```

Usage:

```dart
Text('item_count'.plural(5)) // "5 items"
Text('item_count'.plural(1)) // "One item"
Text('item_count'.plural(0)) // "No items"
```

## Best Practices

### 1. Translation Keys

- Use descriptive, hierarchical keys
- Use snake_case for key names
- Group related keys together

```json
{
  "auth": {
    "login": "Login",
    "logout": "Logout",
    "register": "Register"
  },
  "settings": {
    "theme": "Theme",
    "language": "Language",
    "notifications": "Notifications"
  }
}
```

### 2. Context and Comments

Add comments to translation files for context:

```json
{
  "_comment": "Authentication related translations",
  "login": "Login button text",
  "login_hint": "Username or email input hint"
}
```

### 3. Consistency

- Keep translations consistent across languages
- Use the same terminology throughout the app
- Maintain similar sentence structures

### 4. Testing

Test all languages thoroughly:

```dart
// Test different locales
void main() {
  testWidgets('displays correct language', (tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(),
      ),
    );

    // Test English
    expect(find.text('Welcome'), findsOneWidget);

    // Change to Spanish
    context.setLocale(Locale('es', 'ES'));
    await tester.pump();

    // Test Spanish
    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
```

## Common Issues

### 1. Missing Translations

If a translation key is missing, the key itself will be displayed. Always provide fallback translations.

### 2. Context Issues

Some languages have different grammatical rules. Consider using context-specific translations:

```json
{
  "user_male": "Usuario",
  "user_female": "Usuaria"
}
```

### 3. Text Direction

For RTL languages (Arabic, Hebrew), consider text direction:

```dart
// Check if locale is RTL
bool isRTL = context.locale.languageCode == 'ar';

// Use Directionality widget
Directionality(
  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
  child: Text('content'),
)
```

## Tools and Resources

### Translation Management

- **Google Translate**: For initial translations
- **Professional translators**: For production apps
- **Translation services**: Crowdin, Lokalise, etc.

### Validation Tools

```bash
# Check for missing translations
flutter packages pub run easy_localization:generate -S assets/translations -O lib/generated

# Validate JSON files
dart run tools/validate_translations.dart
```

## Contributing Translations

When contributing translations:

1. **Follow the existing format**
2. **Test thoroughly** in the app
3. **Use native speakers** when possible
4. **Include cultural context** where appropriate
5. **Update documentation** if needed

## Support

For translation-related questions:

- **GitHub Issues**: Report translation bugs
- **Discussions**: Ask for translation help
- **Email**: [contact@monsterspawned.studio](mailto:contact@monsterspawned.studio)

## Additional Resources

- [Easy Localization Documentation](https://pub.dev/packages/easy_localization)
- [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ICU Message Format](https://unicode-org.github.io/icu/userguide/format_parse/messages/)
- [Monster Spawned Studios](https://monsterspawned.studio/)
