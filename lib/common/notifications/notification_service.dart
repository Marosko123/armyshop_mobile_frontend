import 'dart:async';

import 'package:armyshop_mobile_frontend/common/notifications/notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    Timer.periodic(
        const Duration(seconds: 120),
        (Timer t) => showNotification(
              notification: Notifications.getRandomNotification(
                  Notifications.newPromotionNotifications),
            ));
  }

  notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification({required Notification notification}) async {
    return notificationsPlugin.show(
        0, notification.title, notification.body, await notificationDetails());
  }

  void scheduleNotification({
    int id = 0,
    required Notification notification,
    required DateTime scheduledDate,
  }) async =>
      await notificationsPlugin.zonedSchedule(
          id,
          notification.title,
          notification.body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await NotificationService().notificationDetails(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
}
