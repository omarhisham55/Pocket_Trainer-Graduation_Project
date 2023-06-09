import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings('ic_launcher');

  void initializeNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await notification.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );
    await notification.show(0, title, body, notificationDetails);
  }
}
