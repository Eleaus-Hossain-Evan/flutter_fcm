// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easylogger/flutter_logger.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../screen/sign_in_with_phone.dart';
// import '../screen/sign_up_screen.dart';

// Future<bool?> initialize(BuildContext context) async {
//   final initialize =
//       await LocalNotification.instance._notificationsPlugin.initialize(
//     LocalNotification.instance._settings(),
//     onDidReceiveNotificationResponse: (response) {
//       Logger.v("onDidReceiveNotificationResponse: ${response.payload}");
//     },
//     onDidReceiveBackgroundNotificationResponse: (notificationResponse) =>
//         LocalNotification.instance
//             ._backgroundNotificationResponse(notificationResponse, context),
//   );
//   Logger.i("Local notification: $initialize");
//   return initialize;
// }

// class LocalNotification {
//   LocalNotification._();
//   static final LocalNotification instance = LocalNotification._();

//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   get notification => _notificationsPlugin;

//   void _backgroundNotificationResponse(
//       NotificationResponse response, BuildContext context) {
//     Logger.v("onDidReceiveBackgroundNotificationResponse: ${response.payload}");
//     if (response.payload == "email") {
//       Navigator.push(context,
//           CupertinoPageRoute(builder: (context) => const SignUpScreen()));
//     } else if (response.payload == "phone") {
//       Navigator.push(context,
//           CupertinoPageRoute(builder: (context) => const SignInWithPhone()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Invalid Page!"),
//         duration: Duration(seconds: 5),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   showNotification(RemoteMessage message) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       "push_notifications",
//       "PushNotifications",
//       importance: Importance.max,
//       priority: Priority.max,
//     );

//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );

//     await _notificationsPlugin.show(
//       0,
//       message.notification!.title,
//       message.notification!.body,
//       notificationDetails,
//       payload: message.data["body"],
//     );
//   }

//   InitializationSettings _settings() {
//     const androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       defaultPresentAlert: true,
//       defaultPresentBadge: true,
//       defaultPresentSound: true,
//     );

//     return const InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//   }
// }
