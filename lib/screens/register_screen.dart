// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/photo_screen.dart';
import 'package:flutter/material.dart';

import '../components/textfield.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  static const routeName = '/register-screen';
  bool? someValue;

  RegisterScreen({Key? key, this.someValue}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? _hasMilitaryPassport = false;

  void register() {
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

        // password input
        Textfield(
          controller: passwordController,
          hintText: 'Repeat Password',
          obscureText: true,
        ),

        const SizedBox(height: 5),

        CheckboxListTile(
          title: const Text(
            'I have military passport',
          ),
          value: someValue ?? _hasMilitaryPassport,
          onChanged: (newValue) {
            _hasMilitaryPassport = newValue;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PhotoScreen()));
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        // space between password and button
        const SizedBox(height: 10),

        // register button
        MyButton(
          text: 'Register',
          onTap: register,
        ),
      ],
    );
  }
}
