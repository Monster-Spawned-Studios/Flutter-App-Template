# Contributing to Flutter Template

Thank you for your interest in contributing to the Flutter Template project! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [contact@monsterspawned.studio](mailto:contact@monsterspawned.studio).

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter-template.git
   cd flutter-template
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/monsterspawnedstudios/flutter-template.git
   ```
4. **Install dependencies**:
   ```bash
   flutter pub get
   ```

## How to Contribute

### Types of Contributions

We welcome several types of contributions:

- **Bug Reports**: Report bugs and issues
- **Feature Requests**: Suggest new features or improvements
- **Code Contributions**: Submit bug fixes, features, or improvements
- **Documentation**: Improve or add documentation
- **Translations**: Add support for new languages
- **Testing**: Improve test coverage

### Development Setup

1. **Install Flutter SDK** (3.24.0 or higher)
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Install pre-commit hooks**:
   ```bash
   dart pub global activate lefthook
   lefthook install
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

### Pull Request Process

1. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our coding standards

3. **Test your changes**:

   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes**:

   ```bash
   git commit -m "Add: your feature description"
   ```

5. **Push to your fork**:

   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** on GitHub

### Issue Reporting

When reporting issues, please include:

- **Flutter version**: `flutter --version`
- **Platform**: iOS, Android, Web, Desktop
- **Steps to reproduce**: Clear, numbered steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Screenshots**: If applicable
- **Logs**: Any relevant error logs

Use our issue templates:

- [Bug Report](.github/ISSUE_TEMPLATE/BUG_REPORT.yml)
- [Feature Request](.github/ISSUE_TEMPLATE/FEATURE_REQUEST.yml)

## Coding Standards

### Dart/Flutter Standards

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use [Flutter Lints](https://pub.dev/packages/flutter_lints) rules
- Maintain 80%+ test coverage
- Write meaningful commit messages

### Code Formatting

- Use `dart format` for code formatting
- Follow the existing code style
- Use meaningful variable and function names
- Add comments for complex logic

### File Organization

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
├── screens/                 # UI screens
├── widgets/                 # Reusable widgets
├── services/               # Business logic
├── models/                 # Data models
└── utils/                  # Utility functions
```

### Naming Conventions

- **Files**: Use snake_case (e.g., `user_profile_screen.dart`)
- **Classes**: Use PascalCase (e.g., `UserProfileScreen`)
- **Variables**: Use camelCase (e.g., `userName`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `MAX_RETRY_COUNT`)

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for user flows
- Aim for 80%+ code coverage

### Test Structure

```dart
// Example widget test
void main() {
  group('UserProfileScreen', () {
    testWidgets('displays user information', (tester) async {
      // Test implementation
    });
  });
}
```

## Documentation

### Code Documentation

- Document public APIs with DartDoc comments
- Include examples for complex functions
- Keep documentation up-to-date with code changes

### README Updates

- Update README.md for new features
- Include setup instructions for new dependencies
- Document any breaking changes

### Translation Guidelines

When adding new languages:

1. **Create translation file** in `assets/translations/`
2. **Update supported locales** in `main.dart`
3. **Add language option** to `LocaleProvider`
4. **Test translations** thoroughly
5. **Update documentation**

Example:

```json
// assets/translations/it.json
{
  "app_title": "Modello Flutter",
  "welcome": "Benvenuto nel Modello Flutter"
}
```

## Release Process

### Versioning

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Code coverage maintained
- [ ] Documentation updated
- [ ] Version bumped in `pubspec.yaml`
- [ ] CHANGELOG.md updated
- [ ] Release notes prepared

## Community

### Getting Help

- **GitHub Discussions**: For questions and discussions
- **GitHub Issues**: For bug reports and feature requests
- **Email**: [contact@monsterspawned.studio](mailto:contact@monsterspawned.studio)

### Recognition

Contributors will be recognized in:

- CONTRIBUTORS.md file
- Release notes
- Project documentation

## License

By contributing, you agree that your contributions will be licensed under the Monster Spawned Studios License.

## Contact

- **Website**: [https://monsterspawned.studio/](https://monsterspawned.studio/)
- **Email**: [contact@monsterspawned.studio](mailto:contact@monsterspawned.studio)
- **GitHub**: [@monsterspawnedstudios](https://github.com/monsterspawnedstudios)

Thank you for contributing to Flutter Template! 🚀
