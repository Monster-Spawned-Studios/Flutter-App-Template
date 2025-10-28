// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../config/app_config.dart';

/// Singleton logging service with platform-specific configuration
class LoggerService {
  LoggerService._();

  static LoggerService? _instance;
  static LoggerService get instance => _instance ??= LoggerService._();

  Logger? _logger;
  bool _isDebugMode = false;
  bool _enableFileLogging = false;
  bool _isInitialized = false;

  /// Initialize the logger service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _loadConfiguration();
      _setupLogger();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize logger: $e');
      // Initialize with default settings on failure
      _isDebugMode = AppConfig.defaultDebugMode;
      _enableFileLogging = AppConfig.defaultEnableFileLogging;
      _setupLogger();
      _isInitialized = true;
    }
  }

  Future<void> _loadConfiguration() async {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Desktop platforms: read from environment variables
      _isDebugMode = _getEnvBool(
        AppConfig.debugModeEnvVar,
        AppConfig.defaultDebugMode,
      );
      _enableFileLogging = _getEnvBool(
        AppConfig.enableFileLoggingEnvVar,
        AppConfig.defaultEnableFileLogging,
      );
    } else {
      // Mobile platforms: fetch from remote URL
      try {
        final response = await http
            .get(Uri.parse(AppConfig.remoteConfigUrl))
            .timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body) as Map<String, dynamic>;
          _isDebugMode = json['debug_mode'] as bool? ?? true;
          _enableFileLogging = json['enable_file_logging'] as bool? ?? false;
        } else {
          // Fallback to defaults if fetch fails
          _isDebugMode = true;
          _enableFileLogging = false;
        }
      } catch (e) {
        debugPrint('Failed to fetch remote config: $e');
        // Fallback to debug mode on network error
        _isDebugMode = true;
        _enableFileLogging = false;
      }
    }
  }

  bool _getEnvBool(String key, bool defaultValue) {
    final value = Platform.environment[key];
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  void _setupLogger() {
    final output = _enableFileLogging && !kIsWeb
        ? MultiOutput([ConsoleOutput(), FileOutput()])
        : ConsoleOutput();

    _logger = Logger(
      printer: PrettyPrinter(methodCount: 0, lineLength: 80, printTime: true),
      output: output,
      level: _isDebugMode ? Level.debug : Level.nothing,
    );
  }

  /// Log debug message
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized || !_isDebugMode) return;
    _logger?.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log info message
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized || !_isDebugMode) return;
    _logger?.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized || !_isDebugMode) return;
    _logger?.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized || !_isDebugMode) return;
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log critical error
  void wtf(String message, {Object? error, StackTrace? stackTrace}) {
    if (!_isInitialized || !_isDebugMode) return;
    _logger?.f(message, error: error, stackTrace: stackTrace);
  }

  bool get isDebugMode => _isDebugMode;
}

/// Custom file output for logger
class FileOutput extends LogOutput {
  FileOutput()
    : _logFilePath = '',
      _maxFileSizeBytes = AppConfig.maxLogFileSizeKB * 1024;

  final String _logFilePath;
  final int _maxFileSizeBytes;

  @override
  void output(OutputEvent event) {
    // File output not implemented yet
    // Would write logs to file at _logFilePath
    // Respects _maxFileSizeBytes and log rotation
  }
}
