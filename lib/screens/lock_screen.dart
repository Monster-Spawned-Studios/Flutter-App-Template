// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/logger_service.dart';
import '../widgets/animated_card.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _enteredPin = '';
  bool _isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 50,
                    color: Colors.white,
                  ),
                )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(duration: 800.ms),

            const SizedBox(height: 32),

            // Title
            Text(
                  'unlock_app'.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate(delay: 300.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 48),

            // PIN Display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: index < _enteredPin.length
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 400.ms).scale(),

            if (_showError) ...[
              const SizedBox(height: 16),
              Text(
                'pin_incorrect'.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ).animate().shake(duration: 500.ms).fadeIn(duration: 200.ms),
            ],

            const SizedBox(height: 48),

            // Number Pad
            _buildNumberPad(),

            const SizedBox(height: 32),

            // Biometric Button
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                if (!authProvider.isBiometricEnabled) {
                  return const SizedBox.shrink();
                }

                return AnimatedCard(
                      onTap: _isLoading ? null : _authenticateWithBiometric,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fingerprint,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'use_biometric'.tr(),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.3, end: 0);
              },
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildNumberPad() {
    final numbers = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return Column(
      children: numbers.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final row = rowEntry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.asMap().entries.map((colEntry) {
              final colIndex = colEntry.key;
              final number = colEntry.value;
              final delay = (800 + rowIndex * 100 + colIndex * 50).ms;

              return _buildNumberButton(number, delay);
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumberButton(String number, Duration delay) {
    if (number.isEmpty) {
      return const SizedBox(width: 60, height: 60);
    }

    return AnimatedCard(
          onTap: () => _onNumberPressed(number),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: number == '⌫'
                  ? Icon(
                      Icons.backspace_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  : Text(
                      number,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        )
        .animate(delay: delay)
        .scale(duration: 300.ms, curve: Curves.elasticOut)
        .fadeIn(duration: 200.ms);
  }

  void _onNumberPressed(String number) {
    if (_isLoading) return;

    setState(() {
      _showError = false;

      if (number == '⌫') {
        if (_enteredPin.isNotEmpty) {
          _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
          LoggerService.instance.debug(
            'PIN digit removed, length: ${_enteredPin.length}',
          );
        }
      } else {
        if (_enteredPin.length < 4) {
          _enteredPin += number;
          LoggerService.instance.debug(
            'PIN digit entered, length: ${_enteredPin.length}',
          );

          if (_enteredPin.length == 4) {
            LoggerService.instance.info('PIN entry complete, authenticating');
            _authenticateWithPin();
          }
        }
      }
    });
  }

  Future<void> _authenticateWithPin() async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.authenticateWithPin(_enteredPin);

    setState(() {
      _isLoading = false;
      if (success) {
        LoggerService.instance.info(
          'PIN authentication successful, navigating to home',
        );
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        LoggerService.instance.warning('PIN authentication failed');
        _showError = true;
        _enteredPin = '';
      }
    });
  }

  Future<void> _authenticateWithBiometric() async {
    LoggerService.instance.info(
      'Attempting biometric authentication from lock screen',
    );
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.authenticateWithBiometric();

    setState(() {
      _isLoading = false;
      if (success) {
        LoggerService.instance.info(
          'Biometric authentication successful from lock screen',
        );
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        LoggerService.instance.warning(
          'Biometric authentication failed from lock screen',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('biometric_failed'.tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
