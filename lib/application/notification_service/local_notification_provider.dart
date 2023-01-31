import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_fcm/application/notification_service/notification_model.dart';
import 'package:flutter_fcm/application/route/route_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final flutterLocalNotificationProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

final localPushNotificationProvider = Provider<LocalPushNotification>((ref) {
  final localNotificationsPlugin = ref.watch(flutterLocalNotificationProvider);
  return LocalPushNotification(localNotificationsPlugin, ref);
});

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse detail) {
  Logger.d(
      '------------------------\n| onDidReceiveBackgroundNotificationResponse |\n------------------------');
  Logger.d('detail: $detail');
  Logger.d(
      '--------------------------------------------------------------------------------------------------');
}

class LocalPushNotification {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final Ref _ref;

  LocalPushNotification(this._localNotificationsPlugin, this._ref) {
    _init();
  }

  void _init() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannelMax());

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        Logger.i('Local Notification: $details');
        _handleMessage(details.payload);
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  void showNotification(ReceivedModel message) async {
    Logger.v(message);
    final String bigPicture = await _base64EncodedImage(message.imageUrl);
    await _localNotificationsPlugin.show(
      message.id,
      message.title,
      message.body,
      NotificationDetails(
        android: _androidNotificationDetails(
          BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          ),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.payload,
    );
  }

  Future<String> _base64EncodedImage(String url) async {
    final response = await Dio().get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    final base64Data = base64Encode(response.data ?? []);
    return base64Data;
  }

  AndroidNotificationDetails _androidNotificationDetails(
      StyleInformation? style) {
    return AndroidNotificationDetails("1001", 'Seneral Channel',
        channelDescription: 'this is a general notification channel',
        importance: Importance.max,
        priority: Priority.max,
        channelShowBadge: true,
        styleInformation: style);
  }

  AndroidNotificationChannel _notificationChannelMax() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    return channel;
  }

  void _handleMessage(String? payload) {
    Logger.v(
        '------------------------\n| Handle Local Notification |\n------------------------');

    final Map<String, dynamic> data = jsonDecode(payload ?? '');

    if (data['link'] != null) {
      final String link = data['link'];
      Logger.i('link: $link');
      _ref.watch(routerProvider).push("/$link");
    }
  }
}
