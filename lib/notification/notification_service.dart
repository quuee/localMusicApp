import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //https://github.com/dev-tayy/flutter_local_notification/blob/master/tasker/lib/notification_service.dart

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@drawable/app_music");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // onDidReceiveNotificationResponse: 指定此回调是完全可选的，但在此处它将触发导航到另一个页面并显示与通知关联的有效负载
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        //操作在单击通知时调用回调。LinuxInitializationSettings onDidReceiveNotificationResponse
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
    // Get.toNamed()
  }

  Future<void> showNotifications() async {
    // AndroidNotificationDetails androidNotificationDetails =
    //     const AndroidNotificationDetails(
    //   'your channel id',
    //   'your channel name',
    //   channelDescription: 'your channel description',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   playSound: false,
    //   ticker: 'ticker',
    //   actions: <AndroidNotificationAction>[
    //     AndroidNotificationAction(
    //       "id_1",
    //       'Action 1',
    //       icon: DrawableResourceAndroidBitmap('app_music'),
    //       contextual: true,
    //     ),
    //     AndroidNotificationAction(
    //       'id_2',
    //       'Action 2',
    //       titleColor: Color.fromARGB(255, 255, 0, 0),
    //       icon: DrawableResourceAndroidBitmap('app_music'),
    //     ),
    //     AndroidNotificationAction(
    //       "id_3",
    //       'Action 3',
    //       icon: DrawableResourceAndroidBitmap('app_music'),
    //       showsUserInterface: true,
    //       // By default, Android plugin will dismiss the notification when the
    //       // user tapped on a action (this mimics the behavior on iOS).
    //       cancelNotification: false,
    //     ),
    //   ],
    // );



    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      largeIcon: FilePathAndroidBitmap("music_app"),
      styleInformation: const MediaStyleInformation(),
    );
    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);


    // int id, 通知的唯一标识符
    // String? title, 通知的标题
    // String? body, 通知信息
    // NotificationDetails? notificationDetails, 传递给notificationDetails 对象的地方
    // String? payload, 持有当通知被点选时通过通知传递的数据
    await flutterLocalNotificationsPlugin.show(
        0, '通知的标题', '通知信息', notificationDetails,
        payload: '点击后被回传的数据');


  }


}
