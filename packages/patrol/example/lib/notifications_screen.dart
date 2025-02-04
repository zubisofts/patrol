import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    unawaited(
      _notificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: (notificationResponse) {
          print(
            'NotificationScreen: tapped notification with ID ${notificationResponse.id}',
          );
        },
      ),
    );
  }

  Future<void> _showNotification({
    required String title,
    required String body,
    required int id,
  }) async {
    await _notificationsPlugin.show(
      id,
      title,
      '$body. BTW, this notification has ID $id',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main',
          'Default notification channel',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () async => _showNotification(
              id: 1,
              title: 'Someone liked your recent post',
              body: 'Tap to see who!',
            ),
            child: const Text('Show "someone liked" notification'),
          ),
          TextButton(
            onPressed: () async => _showNotification(
              id: 2,
              title: 'Special offer',
              body: 'We have something special for you!',
            ),
            child: const Text('Show "special offer" notification'),
          ),
        ],
      ),
    );
  }
}
