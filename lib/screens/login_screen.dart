// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:flutter/material.dart';

import '../components/textfield.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    print(emailController.text);
    print(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // email input
        Textfield(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
        ),

        // space between email and password
        const SizedBox(height: 10),

        // password input
        Textfield(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
        ),

        // space between password and button
        const SizedBox(height: 10),

        // login button
        MyButton(
          text: 'Log In',
          onTap: login,
        ),

        // space between button and forgot password
        const SizedBox(height: 10),

        // forgot password
        Text(
          'Forgot password?',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
