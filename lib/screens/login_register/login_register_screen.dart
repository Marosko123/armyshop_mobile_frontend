// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:flutter/material.dart';

import '../../components/switch_button.dart';

import 'register_screen.dart';
import 'login_screen.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/login-register-screen';

  @override
  LoginRegisterScreenState createState() => LoginRegisterScreenState();
}

class LoginRegisterScreenState extends State<LoginRegisterScreen> {
  static const routeName = '/login-register-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoginScreenOn = true;

  void login() {
    print(emailController.text);
    print(passwordController.text);
  }

  //TODO: Ulozit prihlaseneho uzivatela, autentifikacia a button Forgot password?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArmyshopColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),

                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BackButton(
                        color: ArmyshopColors.textColor,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            _isLoginScreenOn ? 'Log In' : 'Register',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ArmyshopColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(
                  color: ArmyshopColors.dividerColor,
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
                        setState(() {
                          _isLoginScreenOn = false;
                        });
                      },
                      isHighlighted: !_isLoginScreenOn,
                    ),
                    SwitchButton(
                      text: 'Log In',
                      onTap: () {
                        setState(() {
                          _isLoginScreenOn = true;
                        });
                      },
                      isHighlighted: _isLoginScreenOn,
                    ),
                  ],
                ),

                // space between login and icon
                const SizedBox(height: 10),

                Image(
                  image: const AssetImage('assets/images/logoTransparent.png'),
                  width: 200,
                  color: ArmyshopColors.logoColor,
                  fit: BoxFit.contain,
                ),

                // space between icon and email
                const SizedBox(height: 10),

                if (_isLoginScreenOn)
                  const LoginScreen()
                else
                  const RegisterScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
