import 'package:flutter/material.dart';

class UserShoppingCart extends StatelessWidget {
  static const routeName = '/user-shopping-cart-screen';

  const UserShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'User ShoppingCart',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
