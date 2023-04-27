import 'package:armyshop_mobile_frontend/models/Product.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:armyshop_mobile_frontend/screens/product_detail.dart';
import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';
import '../common/global_variables.dart';
import '../common/request_handler.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/products-screen';

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  // bool isLiked = false;
  List<int> likedList = [];
  int userId = 1;
  bool isLoggedIn = GlobalVariables.isUserLoggedIn;

  // void _toggleLike() {
  //   setState(() {
  //     isLiked = !isLiked;
  //   });
  // }

  void getLikedProducts() {
    RequestHandler.getLikedProducts(1).then((value) {
      setState(() {
        likedList = value;
        print(value);
      });
    });
  }

  // add to liked products
  void addToLikedProducts(int userId, int productId) {
    if (!isLoggedIn) {
      if (!likedList.contains(productId)) {
        likedList.add(productId);
      }
      return;
    }
    RequestHandler.addToLikedProducts(userId, productId).then((value) {
      setState(() {
        if (value) {
          if (!likedList.contains(productId)) {
            likedList.add(productId);
            print("product added to liked list");
          }
        }
      });
    });
  }

  // remove from liked products
  void removeFromLikedProducts(int userId, int productId) {
    if (!isLoggedIn) {
      likedList.remove(productId);
      return;
    }
    RequestHandler.removeFromLikedProducts(userId, productId).then((value) {
      setState(() {
        if (value) {
          if (likedList.contains(productId)) {
            likedList.remove(productId);
            print("product removed from liked list");
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (GlobalVariables.isConnectedToServer) {
      getLikedProducts();
    }
  }

  final Map<String, List<int>> categorySubcategoryMap = {
    "weapons": [1, 2, 3, 4, 5],
    "transport": [6, 7, 8, 9, 10],
    "clothing": [11, 12, 13, 14, 15],
    "explosives": [16, 17, 18, 19, 20],
    "equipment": [21, 22, 23],
    "accessories": [24, 25, 26],
  };

  @override
  Widget build(BuildContext context) {
    final String categoryName =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'All';

    List<Product> productsToDisplay = [];
    if (categoryName != 'All') {
      productsToDisplay = GlobalVariables.products
          .where((product) =>
              categorySubcategoryMap[categoryName.toLowerCase()]!
                  .contains(int.parse(product.subcategoryId?.toString() ?? '')))
          .toList();
    } else {
      productsToDisplay = GlobalVariables.products;
    }

    print(productsToDisplay.length);

    if (productsToDisplay.isEmpty) {
      return Scaffold(
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
                    'Products',
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

        const Center(
          child: Text(
            'No products available',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]))));
    }

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
                      'Products',
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

          Column(
            children: [
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                    children: List.generate(
                      productsToDisplay.length,
                      (index) {
                        final product = productsToDisplay[index];
                        final isLiked = likedList.contains(product.id);
                        return _buildCard(
                          product.name ?? '',
                          '\$${product.price}',
                          product.imageUrl ?? '',
                          isLiked,
                          (liked) {
                            setState(() {
                              if (liked) {
                                addToLikedProducts(userId, product.id!);
                              } else {
                                removeFromLikedProducts(userId, product.id!);
                              }
                            });
                          },
                          context,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0)
            ],
          )
        ]))));
  }

  Widget _buildCard(String name, String price, String image, bool isLiked,
      Function(bool) onLiked, BuildContext context) {
    // set the height of the card
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardHeight;

    if (deviceWidth < 600) {
      cardHeight = MediaQuery.of(context).size.height * 0.14;
    } else if (deviceWidth < 800) {
      cardHeight = MediaQuery.of(context).size.height * 0.26;
    } else if (deviceWidth < 1000) {
      cardHeight = MediaQuery.of(context).size.height * 0.40;
    } else {
      cardHeight = MediaQuery.of(context).size.height * 0.50;
    }

    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigate to the product detail page
                  Navigator.of(context).pushNamed(ProductPage.routeName);
                },
                child: Container(
                  height: cardHeight,
                  width: double.infinity,
                  child: Hero(
                    tag: image,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: IconButton(
                            onPressed: () {
                              onLiked(!isLiked);
                            },
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                              size: 40,
                              // color: isLiked ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.shopping_basket,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  Container(
                    height: 25.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the product detail page
                          Navigator.of(context)
                              .pushNamed(PaymentScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ArmyshopColors.buttonColor,
                        ),
                        child: const Text('Order'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
