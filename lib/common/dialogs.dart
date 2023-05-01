import 'dart:io';

import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';

import 'notifications/notification_service.dart';
import 'notifications/notifications.dart';

class Dialogs {
  static void showPopup(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return the Dialog widget
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: AlertDialog(
              content: SizedBox(
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18.0)),
                    const SizedBox(height: 20.0),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // hide the popup after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  static void showSuccessfulPaymentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // send successful payment notification
        if (!Platform.isWindows) {
          NotificationService().scheduleNotification(
              notification: Notifications.getRandomNotification(
                  Notifications.purchaseNotifications),
              scheduledDate: DateTime.now().add(const Duration(seconds: 10)));
        }

        // return the Dialog widget wrapped with GestureDetector
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: const AlertDialog(
            title: Text('Thank you for your order!'),
            content: Text('You will be redirected in 2 seconds'),
          ),
        );
      },
    );

    // redirect to another page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).popAndPushNamed(PrimaryPage.routeName);
    });
  }
}
