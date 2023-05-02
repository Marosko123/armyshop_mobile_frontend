// ignore_for_file: avoid_print

import 'dart:io';

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/photo_screen.dart';
import 'package:armyshop_mobile_frontend/common/server_handling/request_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/dialogs.dart';
import '../../common/notifications/notification_service.dart';
import '../../common/notifications/notifications.dart';
import '../../components/textfield.dart';
import '../../common/user_authenticator.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  String errorText = '';

  final emailController =
      TextEditingController(text: GlobalVariables.tmpData['email']);
  final passwordController1 =
      TextEditingController(text: GlobalVariables.tmpData['password1']);
  final passwordController2 =
      TextEditingController(text: GlobalVariables.tmpData['password2']);

  Future<void> register() async {
    dynamic user;
    dynamic response;

    try {
      response = await RequestHandler.register(
        emailController.text,
        passwordController1.text,
        passwordController2.text,
        GlobalVariables.user.licensePicture.isEmpty
            ? ''
            : GlobalVariables.user.licensePicture,
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

      final UserAuthenticator userAuthenticator = UserAuthenticator();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Set the token
      if (response['token'] != null) {
        GlobalVariables.token = response['token'];
        prefs.setString('token', response['token']);
      } else {
        prefs.setString('token', '');
      }

      prefs.setInt('user_id', user['id']);

      // send registration notification
      if (!Platform.isWindows) {
        NotificationService().scheduleNotification(
            notification: Notifications.getRandomNotification(
                Notifications.welcomeNotifications),
            scheduledDate: DateTime.now().add(const Duration(seconds: 10)));
      }

      // ignore: use_build_context_synchronously
      return userAuthenticator.userSuccessfullyLoggedIn(
          user: user, context: context);
    }

    if (response['status'] == 422 || response['status'] == 409) {
      final errors = response['errors'];
      errorText = errors.entries.first.value[0];
    } else if (response['error'].isNotEmpty) {
      // ignore: use_build_context_synchronously
      Dialogs.showPopup(
          context, 'You are offline', 'Please check your connection');
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
          controller: passwordController1,
          hintText: 'Password',
          obscureText: true,
        ),

        // space between password and button
        const SizedBox(height: 10),

        // password input
        Textfield(
          controller: passwordController2,
          hintText: 'Repeat Password',
          obscureText: true,
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: ArmyshopColors.dropdownContentColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: CheckboxListTile(
              tileColor: ArmyshopColors.backgroundColor,
              activeColor: ArmyshopColors.textColor,
              checkColor: ArmyshopColors.textColor,
              title: Text(
                'I have military passport',
                style: TextStyle(
                  color: ArmyshopColors.textColor,
                ),
              ),
              value: GlobalVariables.user.licensePicture.isNotEmpty,
              onChanged: (newValue) {
                GlobalVariables.tmpData = {
                  'email': emailController.text,
                  'password1': passwordController1.text,
                  'password2': passwordController2.text,
                  'previousScreen': '',
                  'picture': '',
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhotoScreen(),
                  ),
                );
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
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

        // register button
        MyButton(
          text: 'Register',
          onTap: register,
        ),
      ],
    );
  }
}
