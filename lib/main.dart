import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_fcm/application/notification_service/firebase_push_notification_provider.dart';
import 'package:flutter_fcm/application/route/route_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.init(
    true, // isEnable ，if production ，please false
    isShowFile: false, // In the IDE, whether the file name is displayed
    isShowTime: false, // In the IDE, whether the time is displayed

    phoneVerbose: Colors.white70,
    phoneDebug: const Color(0xffADD8E6),
    phoneInfo: Colors.greenAccent.shade400,
    phoneWarn: Colors.yellowAccent,
    phoneError: Colors.redAccent.shade200,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final container = ProviderContainer();
  final notificationService = container.read(firebasePushNotificationProvider);

  // await NotificationService.initialize();

  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
