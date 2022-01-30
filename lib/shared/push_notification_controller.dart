import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RemoteMessage? messageFromNotification;
  static const String _channelId = '123';
  static const String _channelName = 'Hamrakura Notification Channel';
  static const String _channelDescription =
      'Hamrakura Notification Description';
  static const Importance _channelImportance = Importance.max;
  static const Priority _channelPriority = Priority.high;
  static const String _channelTicker = 'ticker';
  static const String _iconName = '@drawable/ic_stat_name';
  static const String _notificationSound = 'inflicted';
  BuildContext? buildContext;

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    // FirebaseNotification().checkNavigate(message, navigatorKey.currentContext);
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    _channelId,
    _channelName,
    _channelDescription,
    importance: _channelImportance,
  );

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    _channelId,
    _channelName,
    _channelDescription,
    // importance: _channelImportance,
    // priority: _channelPriority,
    // ticker: _channelTicker,
    icon: _iconName,
    color: Color(0Xff2E3192),
  );

  firebaseOnMessage(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      BuildContext context) async {
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);
    Future onSelectNotification(String? payload) async {
      print(payload);
      await firebaseNavigate(context);
    }

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      messageFromNotification = message;

      RemoteNotification notification = message.notification!;
      // AndroidNotification android = message.notification?.android;

      if (notification != null) {
        // _showNotificationCustomSound();
        await flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          platformChannelSpecifics,
        );
      }
    });
  }

  // Future<void> _showNotificationCustomSound() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your other channel id',
  //     'your other channel name',
  //     'your other channel description',
  //     sound: RawResourceAndroidNotificationSound('inflicted'),
  //   );
  //   const IOSNotificationDetails iOSPlatformChannelSpecifics =
  //       IOSNotificationDetails(sound: 'slow_spring_board.aiff');
  //   const MacOSNotificationDetails macOSPlatformChannelSpecifics =
  //       MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //     macOS: macOSPlatformChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'custom sound notification title',
  //     'custom sound notification body',
  //     platformChannelSpecifics,
  //   );
  // }

  static Future<void> _createNotificationChannel(
      FlutterLocalNotificationsPlugin plugin) async {
    final androidNotificationChannel = AndroidNotificationChannel(
      channel.id,
      channel.name,
      channel.description,
      importance: channel.importance,
    );
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    return showDialog(
      context: buildContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              firebaseNavigate(context);
            },
          )
        ],
      ),
    );
  }

  firebaseNavigate(BuildContext context) async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        checkNavigate(message, context);
      } else if (messageFromNotification != null) {
        checkNavigate(messageFromNotification!, context);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      checkNavigate(message, context);
    });
  }

  checkNavigate(RemoteMessage message, BuildContext context) async {
    print(message.data["type"]);
    print(message.data["key"]);
  }

  void initilizeNotification(BuildContext context) async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print(message);
    });
    buildContext = context;
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await _createNotificationChannel(flutterLocalNotificationsPlugin);
    FirebaseNotification()
        .firebaseOnMessage(flutterLocalNotificationsPlugin, context);
    // await _showNotificationCustomSound();
  }
}
