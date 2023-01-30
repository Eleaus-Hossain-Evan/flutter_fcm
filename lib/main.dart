import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_fcm/screen/home_screen.dart';
import 'package:flutter_fcm/service/local_notification.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.init(true, isShowTime: false, isShowFile: false);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    bool notification = false;

    init() async {
      // notification = (await LocalNotification.instance.initialize())!;
    }

    useEffect(() {
      // FCM.instance.getInitialMessage();

      // final sub = FCM.instance.onNotificationOpenedApp.listen((message) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text("App was opened by a notification"),
      //     duration: Duration(seconds: 10),
      //     backgroundColor: Colors.green,
      //   ));
      //   FCM.instance.handleMessage(message);
      // });

      init();

      // return sub.cancel;
    }, const []);

    // Logger.v("Local notification: $notification");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
