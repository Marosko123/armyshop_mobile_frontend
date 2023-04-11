import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  static const routeName = '/user-account-screen';

  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'User Account',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
