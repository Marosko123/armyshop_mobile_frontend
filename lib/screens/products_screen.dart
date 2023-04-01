import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/products-screen';

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: const Text('Products Screen'),
    ));
  }
}
