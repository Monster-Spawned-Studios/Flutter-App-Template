// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

/// Configuration constants for the application
class AppConfig {
  AppConfig._();

  // Remote configuration URL for mobile platforms
  // This URL should return JSON with format: {"debug_mode": true, "enable_file_logging": false}
  static const String remoteConfigUrl =
      'https://monsterspawned.studio/data/flutter-template/config.json';

  // Environment variable names for desktop platforms
  static const String debugModeEnvVar = 'DEBUG_MODE';
  static const String enableFileLoggingEnvVar = 'ENABLE_FILE_LOGGING';

  // Default values when configuration is unavailable
  static const bool defaultDebugMode = false;
  static const bool defaultEnableFileLogging = false;

  // App defaults
  static const String appName = 'Flutter Template';
  static const String appMode = 'development'; // development, production
  static const String dateFormat = 'MM-dd-yyyy hh:mm:ss A';

  // File logging settings
  static const String logFileName = 'app_logs.txt';
  static const String logFolderPath = 'logs';
  static const String logLevel = 'debug'; // debug, info, warning, error
  static const int maxLogFileSizeKB = 1000; // 1MB
  static const int maxLogFiles = 5; // Keep up to 5 log files
}
