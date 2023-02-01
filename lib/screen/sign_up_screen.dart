import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  static const route = "/sign_up";
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Logger.d("SignUpScreen");
    });
    return const Scaffold(
      body: Center(
        child: Text(
          "Sign Up....",
          style: TextStyle(),
        ),
      ),
    );
  }
}
