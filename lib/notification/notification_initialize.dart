import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings('logo2.png');

  void initializeNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await notification.initialize(initializationSettings);
  }

  Future<void> sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notification.show(0, title, body, notificationDetails);
  }

  void scheduleNotifications() {
  var now = DateTime.now();
  
  var notification1Date = DateTime(now.year, now.month, now.day, 11);
  var notification2Date = DateTime(now.year, now.month, now.day, 14);
  var notification3Date = DateTime(now.year, now.month, now.day, 20);
  var notification4Date = DateTime(now.year, now.month, now.day, 23);

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: "pocket01",
      title: "Breakfast time!",
      body: "It's time for your first meal today.",
    ),
    schedule: NotificationCalendar.fromDate(date: notification1Date),
  );

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 2,
      channelKey: "pocket01",
      title: "Lunch time!",
      body: "Go take your lunch! You have training!!!",
    ),
    schedule: NotificationCalendar.fromDate(date: notification2Date),
  );

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 3,
      channelKey: "pocket01",
      title: "Dinner time",
      body: "Time for your last meal.",
    ),
    schedule: NotificationCalendar.fromDate(date: notification3Date),
  );

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 4,
      channelKey: "pocket01",
      title: "testing",
      body: "Es7a el bta3 sha8al.",
    ),
    schedule: NotificationCalendar.fromDate(date: notification4Date),
  );
}
}
