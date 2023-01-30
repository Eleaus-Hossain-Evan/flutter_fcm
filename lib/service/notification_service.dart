import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  Logger.i("background message received! ${message.notification!.title}");
}

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        Logger.e(token);
      }

      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      Logger.i("Notifications Initialized!");
    }
  }
}
