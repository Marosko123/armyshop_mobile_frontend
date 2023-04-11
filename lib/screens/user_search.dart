import 'package:flutter/material.dart';

class UserSearch extends StatelessWidget {
  static const routeName = '/user-search-screen';

  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'User Search',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
