# Setup Guide

This guide provides detailed setup instructions for the Flutter Template project across different platforms.

## Prerequisites

### Required Software

- **Flutter SDK**: 3.24.0 or higher
- **Dart SDK**: 3.9.2 or higher
- **Git**: Latest version
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA

### Platform-Specific Requirements

#### Android Development

- **Android Studio**: Latest stable version
- **Android SDK**: API level 21 or higher
- **Java Development Kit**: JDK 17 or higher

#### iOS Development (macOS only)

- **Xcode**: Latest stable version
- **CocoaPods**: `sudo gem install cocoapods`
- **iOS Simulator**: Included with Xcode

#### Web Development

- **Chrome**: Latest version
- **Web Server**: For testing (optional)

#### Desktop Development

- **Windows**: Visual Studio 2019 or higher with C++ workload
- **macOS**: Xcode command line tools
- **Linux**: GCC, CMake, Ninja build system

## Installation Steps

### 1. Install Flutter SDK

#### Windows

```bash
# Download Flutter SDK
# Extract to C:\flutter
# Add C:\flutter\bin to PATH

# Verify installation
flutter doctor
```

#### macOS

```bash
# Using Homebrew
brew install --cask flutter

# Or download manually
# Extract to ~/flutter
# Add ~/flutter/bin to PATH

# Verify installation
flutter doctor
```

#### Linux

```bash
# Download Flutter SDK
wget https://storage.googleapis.com/flutter_infra_releases/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz

# Extract
tar xf flutter_linux_3.24.0-stable.tar.xz

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

### 2. Platform Setup

#### Android Setup

1. **Install Android Studio**
2. **Install Android SDK**:
   - Open Android Studio
   - Go to Tools → SDK Manager
   - Install Android SDK Platform 34
   - Install Android SDK Build-Tools 34.0.0
3. **Set up Android Virtual Device**:
   - Go to Tools → AVD Manager
   - Create Virtual Device
   - Choose Pixel 6 or similar
   - Download and install system image
4. **Configure environment variables**:
   ```bash
   export ANDROID_HOME=$HOME/Android/Sdk
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

#### iOS Setup (macOS only)

1. **Install Xcode** from App Store
2. **Install Xcode command line tools**:
   ```bash
   xcode-select --install
   ```
3. **Install CocoaPods**:
   ```bash
   sudo gem install cocoapods
   ```
4. **Accept Xcode license**:
   ```bash
   sudo xcodebuild -license accept
   ```

#### Web Setup

1. **Enable web support**:
   ```bash
   flutter config --enable-web
   ```
2. **Install Chrome** (if not already installed)

#### Desktop Setup

##### Windows

1. **Install Visual Studio 2019 or higher**
2. **Install C++ workload**:
   - Desktop development with C++
   - Windows 10/11 SDK
3. **Enable Windows desktop**:
   ```bash
   flutter config --enable-windows-desktop
   ```

##### macOS

1. **Install Xcode** (already done for iOS)
2. **Enable macOS desktop**:
   ```bash
   flutter config --enable-macos-desktop
   ```

##### Linux

1. **Install dependencies**:

   ```bash
   # Ubuntu/Debian
   sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev

   # Fedora
   sudo dnf install clang cmake ninja-build pkg-config gtk3-devel
   ```

2. **Enable Linux desktop**:
   ```bash
   flutter config --enable-linux-desktop
   ```

### 3. Project Setup

1. **Clone the repository**:

   ```bash
   git clone <repository-url>
   cd flutter-template
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Install pre-commit hooks**:

   ```bash
   dart pub global activate lefthook
   lefthook install
   ```

4. **Verify setup**:
   ```bash
   flutter doctor
   ```

### 4. IDE Configuration

#### VS Code

1. **Install Flutter extension**
2. **Install Dart extension**
3. **Configure settings**:
   ```json
   {
     "dart.flutterSdkPath": "/path/to/flutter",
     "dart.lineLength": 80,
     "editor.formatOnSave": true,
     "editor.rulers": [80]
   }
   ```

#### Android Studio

1. **Install Flutter plugin**
2. **Install Dart plugin**
3. **Configure Flutter SDK path**

### 5. Testing Setup

1. **Run tests**:

   ```bash
   flutter test
   ```

2. **Check code coverage**:

   ```bash
   flutter test --coverage
   ```

3. **Run analysis**:
   ```bash
   flutter analyze
   ```

## Troubleshooting

### Common Issues

#### Flutter Doctor Issues

```bash
# Fix Android license issues
flutter doctor --android-licenses

# Fix iOS issues
sudo xcodebuild -license accept

# Update Flutter
flutter upgrade
```

#### Android Issues

- **SDK not found**: Set ANDROID_HOME environment variable
- **Build tools missing**: Install Android SDK Build-Tools
- **Emulator not starting**: Check virtualization settings

#### iOS Issues

- **CocoaPods issues**: Run `pod install` in ios/ directory
- **Code signing**: Set up Apple Developer account
- **Simulator issues**: Reset iOS Simulator

#### Web Issues

- **Chrome not found**: Install Chrome browser
- **CORS issues**: Use local web server for testing

#### Desktop Issues

- **Build tools missing**: Install platform-specific build tools
- **Dependencies missing**: Install required system packages

### Getting Help

1. **Check Flutter documentation**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
2. **Search GitHub issues**: Look for similar problems
3. **Ask in discussions**: Use GitHub Discussions
4. **Contact support**: [contact@monsterspawned.studio](mailto:contact@monsterspawned.studio)

## Next Steps

After completing the setup:

1. **Run the app**: `flutter run`
2. **Explore the code**: Check out the project structure
3. **Read the documentation**: Review README.md and other docs
4. **Start developing**: Make your first changes
5. **Contribute**: Submit pull requests and issues

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Samples](https://github.com/flutter/samples)
- [Monster Spawned Studios](https://monsterspawned.studio/)
