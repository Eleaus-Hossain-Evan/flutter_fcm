// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/screen/sign_in_with_phone.dart';
import 'package:flutter_fcm/screen/sign_up_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  static const route = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context, ref) {
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
