import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notifi_page.dart';

class NotificationsService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initail() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        // ignore: missing_return
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      print("onDidReceiveLocalNotification called.");
    });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // ignore: missing_return
        onSelectNotification: (payload) async {
      Get.to(() => NotifiedPage(label: payload), arguments: payload);
      print("onSelectNotification called.");
    });
  }

  Future<void> sendNotification(
      int id, String message, String dateTime, String dataId) async {
    int hour = dateTime.split(' ')[2] == 'PM'
        ? int.parse(dateTime.split(' ')[1].split(':')[0].split(' ')[0]) + 12
        : int.parse(dateTime.split(' ')[1].split(':')[0].split(' ')[0]);
    int min = dateTime.split(' ')[2] == 'PM'
        ? int.parse(dateTime.split(' ')[1].split(':')[1].split(' ')[0]) + 12
        : int.parse(dateTime.split(' ')[1].split(':')[1].split(' ')[0]);
    Duration resultDatetime = DateTime.now().difference(DateTime.parse(
        '${dateTime.split(' ')[0]} ${hour.toString().length == 1 ? '0' : ''}$hour:${min.toString().length == 1 ? '0' : ''}$min'));

    // print(resultDatetime);

    String checkNegative = resultDatetime.toString().replaceAll('-', '');
    int resultHour = int.parse(checkNegative.split(':')[0]);
    int resultMinute = int.parse(checkNegative.split(':')[1]);
    // int resultSec = int.parse(checkNegative.split(':')[2].split('.')[0]);

    // print(checkNegative);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        id.toString(), 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        channelDescription: 'flutter',
        importance: Importance.max,
        priority: Priority.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'การแจ้งเตือน',
      '$message',
      tz.TZDateTime.now(tz.local).add(Duration(
        hours: resultHour,
        minutes: resultMinute,
        seconds: 0,
      )),
      platformChannelSpecifics,
      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: dataId,
    );
  }

  Future<void> sendNotificationNow(
      int id, String message, String dataId) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        id.toString(), 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        channelDescription: 'flutter',
        importance: Importance.max,
        priority: Priority.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      'การแจ้งเตือน',
      message,
      platformChannelSpecifics,
      payload: dataId,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
