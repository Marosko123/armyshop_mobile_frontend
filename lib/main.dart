import 'package:armyshop_mobile_frontend/screens/login_register_screen.dart';
import 'package:armyshop_mobile_frontend/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import './screens/products_screen.dart';
import 'homePage.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armyshop frontend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        ProductsScreen.routeName: (context) => const HomePage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginRegisterScreen.routeName: (context) => const LoginRegisterScreen(),
      },
    );
  }
}
