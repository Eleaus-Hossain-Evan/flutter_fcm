import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_fcm/application/notification_service/local_notification_provider.dart';
import 'package:flutter_fcm/application/notification_service/notification_model.dart';
import 'package:flutter_fcm/application/route/route_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final firebasePushNotificationProvider =
    Provider<FirebasePushNotification>((ref) {
  final firebaseMessaging = ref.watch(firebaseMessagingProvider);

  final localPushNotification = ref.watch(localPushNotificationProvider);

  return FirebasePushNotification(
      firebaseMessaging, localPushNotification, ref);
});

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  Logger.d(
      '------------------------\n| onBackgroundMessage |\n------------------------');
  Logger.d('Message: ${message.messageId}');
  Logger.d('title: ${message.notification!.title}');
  Logger.d('body: ${message.notification!.body}');
  Logger.d('payload: ${message.data}');
  Logger.d(
      '---------------------------------------------------------------------------');
}

class FirebasePushNotification {
  final FirebaseMessaging _messaging;
  final LocalPushNotification _localPushNotification;
  final Ref _ref;

  FirebasePushNotification(
      this._messaging, this._localPushNotification, this._ref) {
    _init();
    _onFirebaseMessageReceived();
    _setupInteractedMessage();
  }

  void _init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Logger.v('User granted permission');
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        Logger.i(token);
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Logger.w('User granted provisional permission');
    } else {
      Logger.w('User declined or has not accepted permission');
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void _onFirebaseMessageReceived() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      Map<String, dynamic> data = message.data;

      if (notification != null && android != null) {
        Logger.d(
            '------------------------\n| onMessage |\n------------------------');
        Logger.d('Message: ${message.messageId}');
        Logger.d('Notification: ${notification.toMap()}');
        Logger.d('Android: ${android.toMap()}');
        Logger.d(
            '----------------------------------------------------------------');
        _localPushNotification.showNotification(
          ReceivedModel(
            id: notification.hashCode,
            title: notification.title ?? '',
            body: notification.body ?? '',
            imageUrl: android.imageUrl ?? '',
            payload: jsonEncode(data),
          ),
        );
      }
    });
  }

  Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Logger.v(
        '------------------------\n| _handleMessage |\n------------------------');

    if (message.data['link'] != null) {
      final String link = message.data['link'];
      Logger.i('link: $link');
      _ref.watch(routerProvider).push("/$link");
    }
  }
}
