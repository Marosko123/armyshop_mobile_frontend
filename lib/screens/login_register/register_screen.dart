// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/photo_screen.dart';
import 'package:armyshop_mobile_frontend/common/request_handler.dart';
import 'package:flutter/material.dart';

import '../../components/textfield.dart';
import '../../common/user_authenticator.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final RequestHandler _requestHandler = RequestHandler();
  bool? someValue;
  String errorText = '';

  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  bool? _hasMilitaryPassport = false;

  Future<void> register() async {
    dynamic user;

    final response = await _requestHandler.register(
      emailController.text,
      passwordController1.text,
      passwordController2.text,
      _hasMilitaryPassport!,
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
              value: someValue ?? _hasMilitaryPassport,
              onChanged: (newValue) {
                _hasMilitaryPassport = newValue;
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