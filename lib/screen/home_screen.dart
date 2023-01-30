// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/screen/sign_in_with_phone.dart';
import 'package:flutter_fcm/screen/sign_up_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/local_notification.dart';
import '../service/notification_service.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context, ref) {
    void getInitialMessage() async {
      RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();

      if (message != null) {
        if (message.data["page"] == "email") {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const SignUpScreen()));
        } else if (message.data["page"] == "phone") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const SignInWithPhone()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid Page!"),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    useEffect(() {
      getInitialMessage();

      FirebaseMessaging.onMessage.listen((message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.data["myname"].toString()),
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.green,
        ));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("App was opened by a notification"),
          duration: Duration(seconds: 10),
          backgroundColor: Colors.green,
        ));
      });
      // initialize(context);

      //  init();

      return (() {
        // onNotificationOpenedApp.cancel;
        // onMessage.cancel;
      });
    }, const []);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () async {},
                padding: EdgeInsets.zero,
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                  backgroundColor: Colors.grey,
                ),
              ),
              const TextField(
                decoration: InputDecoration(hintText: "Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(hintText: "Email Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(hintText: "Age"),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
