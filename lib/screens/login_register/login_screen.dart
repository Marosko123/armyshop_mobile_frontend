// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/common/user_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/auth_state.dart';
import '../../common/global_variables.dart';
import '../../components/textfield.dart';
import '../../common/request_handler.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String errorText = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    dynamic user;
    dynamic response;

    try {
      response = await RequestHandler.login(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      print(e);
      return setState(() {
        errorText = e.toString();
      });
    }

    if (response['status'] == 200 || response['status'] == 'success') {
      user = response['user'];
      // Set the token
      GlobalVariables.token = response['token'];
      // ignore: use_build_context_synchronously
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['token']);
      // ignore: use_build_context_synchronously  
      final UserAuthenticator userAuthenticator = UserAuthenticator();
      // ignore: use_build_context_synchronously
      return userAuthenticator.userSuccessfullyLoggedIn(
          user: user, context: context);
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
      ],
    );
  }
}
