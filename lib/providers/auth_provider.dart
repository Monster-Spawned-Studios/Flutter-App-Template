// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _loadAuthSettings();
  }
  static const String _isLockedKey = 'is_locked';
  static const String _pinKey = 'user_pin';
  static const String _biometricEnabledKey = 'biometric_enabled';

  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _isLocked = false;
  bool _isBiometricEnabled = false;
  String _userPin = '';

  bool get isLocked => _isLocked;
  bool get isBiometricEnabled => _isBiometricEnabled;
  String get userPin => _userPin;

  Future<void> _loadAuthSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isLocked = prefs.getBool(_isLockedKey) ?? false;
    _isBiometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
    _userPin = prefs.getString(_pinKey) ?? '';
    notifyListeners();
  }

  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  Future<bool> authenticateWithBiometric() async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;

      final result = await _localAuth.authenticate(
        localizedReason: 'Unlock App',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (result) {
        await unlockApp();
      }

      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticateWithPin(String pin) async {
    if (pin == _userPin) {
      await unlockApp();
      return true;
    }
    return false;
  }

  Future<void> setPin(String pin) async {
    _userPin = pin;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, pin);
    notifyListeners();
  }

  Future<void> enableBiometric(bool enabled) async {
    if (enabled) {
      // Using the correct permission type for biometric authentication.
      final permissionStatus = await Permission.sensors.request();
      if (permissionStatus.isDenied) {
        throw Exception('Biometric permission denied');
      }
    }

    _isBiometricEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
    notifyListeners();
  }

  Future<void> lockApp() async {
    _isLocked = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLockedKey, true);
    notifyListeners();
  }

  Future<void> unlockApp() async {
    _isLocked = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLockedKey, false);
    notifyListeners();
  }

  Future<void> clearAuth() async {
    _userPin = '';
    _isBiometricEnabled = false;
    _isLocked = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pinKey);
    await prefs.remove(_biometricEnabledKey);
    await prefs.remove(_isLockedKey);
    notifyListeners();
  }
}
