// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/photo_screen.dart';
import 'package:flutter/material.dart';

import '../components/switch_button.dart';
import '../components/textfield.dart';

import './login_screen.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
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
                            'Register',
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

                // space between register and switch
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SwitchButton(
                      text: 'Register',
                      onTap: null,
                      isHighlighted: true,
                    ),
                    SwitchButton(
                      text: 'Log In',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      isHighlighted: false,
                    ),
                  ],
                ),

                // space between
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
                        MaterialPageRoute(builder: (context) => PhotoScreen()));
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

                // space between button and forgot password
                const SizedBox(height: 10),

                // forgot password
                Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
