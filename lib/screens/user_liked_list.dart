import 'package:flutter/material.dart';

class UserLikedList extends StatelessWidget {
  static const routeName = '/user-liked-list-screen';

  const UserLikedList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'User LikedList',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
