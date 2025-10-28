// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

import '../services/logger_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() {
    _initializeNotifications();
    Future.microtask(
      () => LoggerService.instance.info('NotificationProvider initialized'),
    );
  }
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _isPermissionGranted = false;

  bool get isInitialized => _isInitialized;
  bool get isPermissionGranted => _isPermissionGranted;

  Future<void> _initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
    await _requestPermission();
    notifyListeners();
    LoggerService.instance.debug(
      'Notifications initialized - permission: $_isPermissionGranted',
    );
  }

  Future<void> _requestPermission() async {
    final permission = await Permission.notification.request();
    _isPermissionGranted = permission.isGranted;
    notifyListeners();
    LoggerService.instance.debug(
      'Notification permission: $_isPermissionGranted',
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    LoggerService.instance.info('Notification tapped: ${response.payload}');
  }

  Future<void> showHelloWorldNotification() async {
    LoggerService.instance.info('Showing hello world notification');
    if (!_isInitialized || !_isPermissionGranted) {
      LoggerService.instance.warning(
        'Notification not shown - initialized: $_isInitialized, granted: $_isPermissionGranted',
      );
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'hello_world_channel',
      'Hello World Notifications',
      channelDescription: 'Sample notifications for Flutter Template',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      0,
      'Flutter Template',
      'This is a sample notification from Flutter Template',
      details,
      payload: 'hello_world',
    );
    LoggerService.instance.debug('Hello world notification sent');
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    LoggerService.instance.info(
      'Scheduling notification: $title at $scheduledDate',
    );
    if (!_isInitialized || !_isPermissionGranted) return;

    const androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Scheduled notifications for Flutter Template',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
    LoggerService.instance.debug('Notification scheduled with id: $id');
  }

  Future<void> cancelNotification(int id) async {
    LoggerService.instance.debug('Cancelling notification with id: $id');
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    LoggerService.instance.info('Cancelling all notifications');
    await _notifications.cancelAll();
  }
}
