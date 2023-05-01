import 'package:armyshop_mobile_frontend/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import '../common/serialisation/serializer.dart';
import '../common/server_handling/request_handler.dart';
import '../models/product.dart';

// import '../common/global_variables.dart';
// import '../common/request_handler.dart';
// import '../models/Product.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/user-home-screen';

  const UserHome({super.key});

  @override
  UserHomeState createState() => UserHomeState();
}

class UserHomeState extends State<UserHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/army-bg1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Welcome to ArmyShop!',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                shrinkWrap: true,
                children: [
                  _buildCategory(
                    "Weapons",
                    'assets/images/icons/gun-pistol-icon.png',
                  ),
                  _buildCategory(
                    "Transport",
                    'assets/images/icons/tank.png',
                  ),
                  _buildCategory(
                    "Clothing",
                    'assets/images/icons/tshirt.png',
                  ),
                  _buildCategory(
                    "Explosives",
                    'assets/images/icons/bomb.png',
                  ),
                  _buildCategory(
                    "Equipment",
                    'assets/images/icons/backpack.png',
                  ),
                  _buildCategory(
                    "Accessories",
                    'assets/images/icons/dog-tag.png',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Widget _buildCategory(String name, String image) {
    return GestureDetector(
      onTap: () async {
        List<Product> products =
            (await RequestHandler.getProducts()).cast<Product>();
        if (products.isNotEmpty) {
          GlobalVariables.products = products;
        } else {
          GlobalVariables.products = await Serializer.deserialize();
        }
        Navigator.of(context).pushNamed(
          ProductsScreen.routeName,
          arguments: name,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 48.0, height: 48.0),
            const SizedBox(height: 8.0),
            Text(name, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
