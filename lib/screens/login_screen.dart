// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:flutter/material.dart';

import '../components/switch_button.dart';
import '../components/textfield.dart';

import './register_screen.dart';

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
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              Row(
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              // space between login and switch
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchButton(
                    text: 'Register',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    isHighlighted: false,
                  ),
                  const SwitchButton(
                    text: 'Log In',
                    onTap: null,
                    isHighlighted: true,
                  ),
                ],
              ),

              // space between login and icon
              const SizedBox(height: 10),

              const Image(
                image: AssetImage('assets/images/logoTransparent.png'),
                width: 200,
                color: Color.fromARGB(255, 20, 90, 11),
                fit: BoxFit.contain,
              ),

              // space between icon and email
              const SizedBox(height: 10),

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
          )),
        ));
  }
}
