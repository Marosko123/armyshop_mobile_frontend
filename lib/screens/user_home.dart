import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  static const routeName = '/user-home-screen';

  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'User Home',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
