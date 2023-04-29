import 'package:armyshop_mobile_frontend/screens/product_detail.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import '../components/search_window.dart';
import '../models/Product.dart';

class UserSearch extends StatefulWidget {
  static const routeName = '/user-search';

  const UserSearch({Key? key}) : super(key: key);

  @override
  UserSearchState createState() => UserSearchState();
}

class UserSearchState extends State<UserSearch> {
  List<Product> products = GlobalVariables.products;

  List<Product> searchResults = [];

  List<Product> searchProducts(String query) {
    return products
        .where((product) =>
            product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  ImageProvider<Object> _getImageProvider(dynamic image) {
    if (image is String &&
        GlobalVariables.isConnectedToServer &&
        image.isNotEmpty) {
      return NetworkImage(image);
    } else if (image is AssetImage) {
      return image;
    } else {
      return const AssetImage('assets/images/army-bg1.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                searchResults = searchProducts(value);
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              hintText: 'Search Products...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search),
            ),
          ),

          // SearchWindow(searchProducts: searchProducts),
          Expanded(
            child: GridView.builder(
              itemCount: searchResults.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the product detail page
                    Navigator.of(context).pushNamed(ProductPage.routeName,
                        arguments: {'id': searchResults[index].id!});
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _getImageProvider(
                                  searchResults[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(searchResults[index].name!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
