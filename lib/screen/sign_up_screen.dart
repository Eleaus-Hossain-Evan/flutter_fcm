import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const route = "/sign_up";
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
