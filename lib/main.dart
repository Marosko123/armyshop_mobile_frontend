import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:armyshop_mobile_frontend/screens/chat_rooms.dart';
import 'package:armyshop_mobile_frontend/screens/login_register_screen.dart';
import 'package:armyshop_mobile_frontend/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import './screens/products_screen.dart';
import 'colors.dart';
import 'primary_page.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  ArmyshopColors.setColors();

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
        ProductsScreen.routeName: (context) => const PrimaryPage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginRegisterScreen.routeName: (context) => const LoginRegisterScreen(),
        ChatRooms.routeName: (context) => const ChatRooms(),
        Chat.routeName: (context) => Chat(
            roomName: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
