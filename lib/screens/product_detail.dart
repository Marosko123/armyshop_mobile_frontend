import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/common/request_handler.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:armyshop_mobile_frontend/screens/user_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/currencies.dart';
import '../common/global_variables.dart';
import '../models/Product.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product-page';

  const ProductPage({super.key});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  // get product from database
  // Product product = Product();
  int userId = GlobalVariables.user.id;
  int productId = 1;
  bool isLoggedIn = GlobalVariables.isUserLoggedIn;
  String name = 'AK 47';
  int amount = 1;
  double price = 3.99;
  String formattedPrice = '';
  String formattedTotal = '';
  String image = 'assets/images/army-bg1.jpg';
  String description = 'lorem ipsum dolor sit amet';
  bool isLiked = false;
  double totalPrice = 3.99;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = amount.toString();
  }

  Future<List<int>> getLiked(int userId) async {
    return await RequestHandler.getLikedProducts(userId);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // get the product info
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int id = 1;
    if (arguments.containsKey('id')) {
      id = arguments['id'];
    }
    if (arguments.containsKey('liked')) {
      isLiked = arguments['liked'] as bool;
    } else if (GlobalVariables.isConnectedToServer) {
      // get liked products of user from db
      //List<int> likedProducts = await getLiked(GlobalVariables.user.id);
      // check if the product is liked
      //likedProducts.contains(id) ? isLiked = true : isLiked = false;
      isLiked = false;
    }

    Product product =
        GlobalVariables.products.firstWhere((element) => element.id == id);

    // initialize the values
    name = product.name!;
    amount = 1;
    price = product.price!;
    description = product.description!;
    totalPrice = product.price!;
    productId = product.id!;

    if (GlobalVariables.isConnectedToServer) {
      image = product.imageUrl!;
    }

    // format the price
    price = Currencies.convert(price);
    formattedPrice = Currencies.format(price);
    formattedTotal = Currencies.format(price);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  // add to liked products
  void addToLikedProducts(int productId) {
    if (!GlobalVariables.isConnectedToServer) {
      showPopup(context, 'You are offline', 'Please check your connection');
      return;
    }
    if (!isLoggedIn) {
      showPopup(context, 'You are not logged in', 'Log in to like products');
      return;
    }
    _toggleLike();
    RequestHandler.addToLikedProducts(userId, productId);
  }

  // remove from liked products
  void removeFromLikedProducts(int productId) {
    if (!GlobalVariables.isConnectedToServer) {
      showPopup(context, 'You are offline', 'Please check your connection');
      return;
    }
    if (!isLoggedIn) {
      showPopup(context, 'You are not logged in', 'Log in to like products');
      return;
    }
    _toggleLike();
    RequestHandler.removeFromLikedProducts(userId, productId);
  }

  void _addAmount() {
    setState(() {
      if (amount < 99) {
        amount++;
        _controller.text = amount.toString();
        totalPrice = amount * price;
        formattedTotal = Currencies.format(totalPrice);
      }
    });
  }

  void _removeAmount() {
    setState(() {
      if (amount > 1) {
        amount--;
        _controller.text = amount.toString();
        totalPrice = amount * price;
        formattedTotal = Currencies.format(totalPrice);
      }
    });
  }

  void onAddToBasket(int productId, int amount) {
    if (!GlobalVariables.isConnectedToServer) {
      showPopup(context, 'You are offline', 'Please check your connection');
      return;
    }
    if (!isLoggedIn) {
      showPopup(
          context, 'You are not logged in', 'Log in to add to basket');
      return;
    }
    // add the product to the shopping cart database
    RequestHandler.addToBasket(userId, productId, amount);
    // show popup
    showPopup(context, 'Product added to basket!', 'Go to basket to buy it!');
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

  void showPopup(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return the Dialog widget
        return SizedBox(
          width: 300.0,
          height: 300.0,
          child: AlertDialog(
            content: SizedBox(
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 20.0),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // hide the popup after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: ArmyshopColors.textColor,
                      onPressed: () {
                        Navigator.pop(context, {'refresh': true});
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          name,
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

              SizedBox(
                height: size.height * 1.3,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Material(
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        child: SizedBox(
                          height: size.height * 0.33,
                          width: size.width,
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/images/army-bg1.jpg'),
                            image: _getImageProvider(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.30),
                      height: size.height * 1.5,
                      decoration: BoxDecoration(
                        color: ArmyshopColors.backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 10),
                                Flexible(
                                  flex:
                                      2, // Set the flex property to a value greater than 1
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ArmyshopColors.textColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: IconButton(
                                    onPressed: () {
                                      if (isLiked) {
                                        //print('add to liked products');
                                        addToLikedProducts(productId);
                                      } else {
                                        //print('remove from liked products');
                                        removeFromLikedProducts(productId);
                                      }
                                    },
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 40,
                                      // color: isLiked ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ArmyshopColors.isDarkMode
                                        ? Colors.grey[900]
                                        : Colors.grey[200],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Price for 1: $formattedPrice',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ArmyshopColors.textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // amount
                                      Container(
                                        width: size.width * 0.35,
                                        decoration: BoxDecoration(
                                          color: ArmyshopColors.isDarkMode
                                              ? Colors.grey[700]
                                              : Colors.grey[400],
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: _removeAmount,
                                              icon: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25,
                                              child: TextFormField(
                                                controller: _controller,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'\d+')),
                                                ],
                                                textAlign: TextAlign.center,
                                                onChanged: (value) {
                                                  try {
                                                    setState(() {
                                                      amount = int.parse(value);
                                                      totalPrice =
                                                          amount * price;
                                                      formattedTotal =
                                                          Currencies.format(
                                                              totalPrice);
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      amount = 1;
                                                      totalPrice = price;
                                                      formattedTotal =
                                                          Currencies.format(
                                                              totalPrice);
                                                    });
                                                  }
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: _addAmount,
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // total price
                                      Column(
                                        children: [
                                          Text(
                                            'Total price',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ArmyshopColors.textColor,
                                            ),
                                          ),
                                          Text(
                                            formattedTotal,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: ArmyshopColors.textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const SizedBox(width: 30),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.shopping_basket,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // get the number of products in the cart

                                                // add to cart
                                                onAddToBasket(
                                                    productId, amount);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (!GlobalVariables
                                                    .isConnectedToServer) {
                                                  showPopup(
                                                      context,
                                                      'You are offline',
                                                      'Please check your connection');
                                                  return;
                                                }
                                                if (!isLoggedIn) {
                                                  showPopup(
                                                      context,
                                                      'You are not logged in',
                                                      'Log in to order products');
                                                  return;
                                                }
                                                // Navigate to the product detail page
                                                Navigator.of(context).pushNamed(
                                                    PaymentScreen.routeName);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ArmyshopColors.buttonColor,
                                                foregroundColor: ArmyshopColors
                                                    .buttonTextColor,
                                                // onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ),
                                              child: const Text('Order Now'),
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 16,
                                color: ArmyshopColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
