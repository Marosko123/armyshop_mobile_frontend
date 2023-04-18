import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product-page';

  const ProductPage({super.key});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ProductPage'),
    );
  }
}
