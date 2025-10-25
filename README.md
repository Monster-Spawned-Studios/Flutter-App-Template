# Flutter Template

A comprehensive Flutter app template for Monster Spawned Studios with CI/CD, localization, security, and best practices.

## Features

- 🌍 **Multi-language Support**: English, Spanish, French, German
- 🎨 **Theme Support**: Light, Dark, and System themes
- 🔐 **Biometric Authentication**: Secure fingerprint/face unlock
- 🔔 **Local Notifications**: Push notification system
- 🛡️ **Security Features**: PIN lock and secure storage
- ✨ **Smooth Animations**: Beautiful UI transitions
- 🚀 **CI/CD Ready**: GitHub Actions for iOS/Android builds
- 📝 **Code Quality**: Pre-commit hooks and linting
- 🔒 **Security Scanning**: Git secrets detection
- 📄 **Copyright Headers**: Automatic copyright insertion

## Quick Start

1. **Clone the template**:

   ```bash
   git clone <repository-url>
   cd flutter-template
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Setup Instructions

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code
- Xcode (for iOS development)
- Git

### Platform Setup

#### Android

1. Install Android Studio
2. Set up Android SDK
3. Create virtual device or connect physical device
4. Run `flutter doctor` to verify setup

#### iOS

1. Install Xcode from App Store
2. Install Xcode command line tools: `xcode-select --install`
3. Install CocoaPods: `sudo gem install cocoapods`
4. Run `flutter doctor` to verify setup

#### Web

1. Install Chrome browser
2. Enable web support: `flutter config --enable-web`
3. Run `flutter doctor` to verify setup

#### Desktop (Windows/macOS/Linux)

1. Enable desktop support: `flutter config --enable-windows-desktop` (or macos/linux)
2. Install platform-specific dependencies
3. Run `flutter doctor` to verify setup

## Development

### Code Quality

The template includes several tools to maintain code quality:

- **Dart Format**: Automatic code formatting
- **Flutter Analyze**: Static analysis and linting
- **Git Secrets**: Security scanning for sensitive data
- **Copyright Headers**: Automatic copyright insertion

### Pre-commit Hooks

Install lefthook to enable pre-commit hooks:

```bash
# Install lefthook
dart pub global activate lefthook

# Install git hooks
lefthook install
```

### Adding New Languages

1. Add translation file to `assets/translations/`
2. Update `main.dart` supported locales
3. Add language option to `LocaleProvider`

Example:

```json
// assets/translations/it.json
{
  "app_title": "Modello Flutter",
  "welcome": "Benvenuto nel Modello Flutter"
}
```

### Customizing Themes

Modify `lib/providers/theme_provider.dart` to customize:

- Color schemes
- Typography
- Component themes
- Dark/light mode differences

## CI/CD Workflows

### iOS IPA Build

The template includes a GitHub Actions workflow for building iOS IPAs:

**File**: `.github/workflows/build-ipa.yml`

**Triggers**:

- Version tags (e.g., `v1.0.0`)
- Manual dispatch

**Requirements**:

- Apple Developer Account
- iOS Distribution Certificate
- Provisioning Profile

**Setup**:

1. Export your certificate as `.p12` file
2. Export your provisioning profile as `.mobileprovision` file
3. Add GitHub secrets:
   - `CERTIFICATE_BASE64`: Base64 encoded certificate
   - `CERTIFICATE_PASSWORD`: Certificate password
   - `PROVISIONING_PROFILE_BASE64`: Base64 encoded provisioning profile

### Android APK/AAB Build

**File**: `.github/workflows/build-android.yml`

**Triggers**:

- Version tags (e.g., `v1.0.0`)
- Manual dispatch

**Outputs**:

- Release APK
- Android App Bundle (AAB)

## Security

### Git Secrets

The template includes git-secrets for scanning commits:

```bash
# Install git-secrets
git secrets --install

# Add patterns
git secrets --add 'AKIA[0-9A-Z]{16}'
git secrets --add 'sk_live_[0-9a-zA-Z]{24}'
```

### Copyright Headers

Automatic copyright header insertion:

```bash
# Run manually
dart tools/add_copyright.dart

# Or via pre-commit hook (automatic)
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
│   ├── theme_provider.dart
│   ├── locale_provider.dart
│   ├── auth_provider.dart
│   └── notification_provider.dart
├── screens/                 # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── settings_screen.dart
│   ├── about_screen.dart
│   └── lock_screen.dart
├── widgets/                 # Reusable widgets
│   ├── animated_card.dart
│   ├── language_selector.dart
│   └── theme_selector.dart
└── services/               # Business logic
    └── (to be implemented)

assets/
├── translations/           # Localization files
│   ├── en.json
│   ├── es.json
│   ├── fr.json
│   └── de.json
└── images/                # App assets
    └── (to be added)

tools/
└── add_copyright.dart      # Copyright header script

.github/
└── workflows/             # CI/CD workflows
    ├── build-ipa.yml
    └── build-android.yml
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the Monster Spawned Studios License - see the [LICENSE.md](docs/LICENSE.md) file for details.

## Support

For support and questions:

- Website: [https://monsterspawned.studio/](https://monsterspawned.studio/)
- Issues: [GitHub Issues](https://github.com/monsterspawnedstudios/flutter-template/issues)

## Acknowledgments

- Flutter team for the amazing framework
- Provider package for state management
- Easy Localization for i18n support
- Flutter Animate for smooth animations
- All contributors and the open-source community
