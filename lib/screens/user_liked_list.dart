// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:armyshop_mobile_frontend/screens/product_detail.dart';
import 'package:flutter/material.dart';

import '../common/currencies.dart';
import '../common/dialogs.dart';
import '../common/global_variables.dart';
import '../common/server_handling/request_handler.dart';
import '../models/product.dart';

class UserLikedList extends StatefulWidget {
  static const routeName = '/user-liked-list-screen';

  const UserLikedList({super.key});

  @override
  UserLikedListState createState() => UserLikedListState();
}

class UserLikedListState extends State<UserLikedList> {
  List<int> likedList = [];
  int userId = GlobalVariables.user.id;
  bool isLoggedIn = GlobalVariables.isUserLoggedIn;
  List<Product> productsToDisplay = [];

  void getLikedProducts() {
    RequestHandler.getLikedProducts(GlobalVariables.user.id).then((value) {
      setState(() {
        likedList = value;
        print(value);
        // get the products from the global variable
        productsToDisplay = GlobalVariables.products
            .where((element) => likedList.contains(element.id))
            .toList();
        print(productsToDisplay.length);
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

  void addToBasket(int productId) {
    if (!isLoggedIn) {
      return;
    }
    RequestHandler.addToBasket(userId, productId, 1).then((value) {
      setState(() {
        if (value) {
          print("product added to basket");
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
    // if 0 products or not logged in, show empty list
    if (productsToDisplay.isEmpty || !isLoggedIn) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Text(
            'You have no liked products',
            style: TextStyle(fontSize: 20.0, color: ArmyshopColors.textColor),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/products-screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ArmyshopColors.buttonColor,
              foregroundColor: ArmyshopColors.buttonTextColor,
            ),
            child: const Text('Go to products'),
          )
        ],
      );
    }

    return Column(
      children: [
        const SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 50.0,
            decoration: BoxDecoration(
              color:
                  ArmyshopColors.isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: ArmyshopColors.backgroundColor.withOpacity(0.2),
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
              childAspectRatio: 0.70,
              children: likedList.map((productId) {
                final product =
                    productsToDisplay.firstWhere((p) => p.id == productId);
                final isLiked = likedList.contains(product.id);
                return _buildCard(
                  product.name ?? '',
                  product.price!,
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
                  () {
                    // add to cart
                    setState(() {
                      if (isLoggedIn) {
                        addToBasket(product.id!);
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/login-screen',
                        );
                      }
                    });
                  },
                  product.id!,
                  context,
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 15.0)
      ],
    );
  }

  Widget _buildCard(
      String name,
      double price,
      String image,
      bool isLiked,
      Function(bool) onLiked,
      Function() onAddToBasket,
      int id,
      BuildContext context) {
    // set the height of the card
    double deviceWidth = MediaQuery.of(context).size.width;
    double imgHeight;

    // format the price
    final convertedPrice = Currencies.convert(price);
    final formattedPrice = Currencies.format(convertedPrice);

    if (deviceWidth < 600) {
      imgHeight = MediaQuery.of(context).size.height * 0.16;
    } else if (deviceWidth < 800) {
      imgHeight = MediaQuery.of(context).size.height * 0.26;
    } else if (deviceWidth < 1000) {
      imgHeight = MediaQuery.of(context).size.height * 0.40;
    } else {
      imgHeight = MediaQuery.of(context).size.height * 0.50;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: ArmyshopColors.backgroundColor,
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: ArmyshopColors.isDarkMode
                ? ArmyshopColors.backgroundColor
                : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigate to the product detail page
                  Navigator.of(context).pushNamed(ProductPage.routeName,
                      arguments: {'id': id, 'liked': isLiked}).then((result) {
                    if (result != null &&
                        result is Map<String, dynamic> &&
                        result['refresh'] == true) {
                      setState(() {
                        // refresh liked products
                        likedList = [];
                        getLikedProducts();
                      });
                    }
                  });
                },
                child: SizedBox(
                  height: imgHeight,
                  width: double.infinity,
                  child: Hero(
                    tag: 'image-$id',
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _getImageProvider(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                            style: TextStyle(
                              color: ArmyshopColors.textColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formattedPrice,
                            style: TextStyle(
                              color: ArmyshopColors.textColor,
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: IconButton(
                            onPressed: () {
                              onLiked(!isLiked);
                            },
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                              size: 35,
                              // color: isLiked ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_basket,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                      onPressed: () {
                        // add to cart
                        onAddToBasket();
                        // show popup
                        Dialogs.showPopup(context, 'Product added to basket!',
                            'Go to basket to buy it!');
                      },
                    ),
                  ),
                  Container(
                    height: 30.0,
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
                          foregroundColor: ArmyshopColors.buttonTextColor,
                        ),
                        child:
                            const Text('Order', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
