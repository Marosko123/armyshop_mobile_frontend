// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/common/user_authenticator.dart';
import 'package:flutter/material.dart';

import '../../components/textfield.dart';
import '../../common/request_handler.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final RequestHandler _requestHandler = RequestHandler();
  String errorText = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    dynamic user;

    final response = await _requestHandler.login(
      emailController.text,
      passwordController.text,
    );

    if (response['status'] == 200 || response['status'] == 'success') {
      user = response['user'];

      final UserAuthenticator userAuthenticator = UserAuthenticator();
      // ignore: use_build_context_synchronously
      return userAuthenticator.userSuccessfullyLoggedIn(user, context);
    }

    if (response['status'] == 422) {
      final errors = response['errors'];
      errorText = errors.entries.first.value[0];
    } else if (response['status'] == 401) {
      errorText = response['message'];
    }

    setState(() {});
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

        if (errorText != '')
          Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

        // space between password and button
        if (errorText == '') const SizedBox(height: 19),

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
