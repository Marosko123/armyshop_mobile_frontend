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
    return Scaffold(
        backgroundColor: ArmyshopColors.backgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 10),

              // Header
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
                          'AK 47',
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

              // page content
              const SizedBox(height: 10),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/army-bg1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
