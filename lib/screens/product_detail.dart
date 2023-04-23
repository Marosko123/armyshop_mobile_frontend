import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:armyshop_mobile_frontend/screens/user_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product-page';

  const ProductPage({super.key});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  // get product from database
  // Product product = Product();
  String name = 'AK 47';
  int amount = 1;
  double price = 3.99;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        // Add the product to the liked list database
      } else {
        // Remove the product from the liked list database
      }
    });
  }

  void _addAmount() {
    setState(() {
      if (amount < 99) {
        amount++;
        _controller.text = amount.toString();
        totalPrice = amount * price;
      }
    });
  }

  void _removeAmount() {
    setState(() {
      if (amount > 1) {
        amount--;
        _controller.text = amount.toString();
        totalPrice = amount * price;
      }
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
                height: size.height * 1.5,
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
                          child: Image.asset(
                            'assets/images/army-bg1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.30),
                      height: size.height * 1.5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
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
                                    description,
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
                                    onPressed: _toggleLike,
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
                                    color: Colors.grey[200],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Price for 1: \$$price',
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
                                          color: Colors.grey[400],
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
                                              width: 30,
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
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      amount = 0;
                                                      totalPrice = 0;
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
                                            '${totalPrice.toStringAsFixed(2)} \$',
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
                                          const SizedBox(width: 50),
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
                                                // Navigate to the product detail page
                                                Navigator.of(context).pushNamed(
                                                    UserShoppingCart.routeName);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Navigate to the product detail page
                                                Navigator.of(context).pushNamed(
                                                    PaymentScreen.routeName);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ArmyshopColors.buttonColor,
                                                // onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                              ),
                                              child: const Text('Order now'),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nisl nisl aliquam nisl, eu aliquam nunc nisl euismod nisl. Sed euismod, nunc vel tincidunt lacinia, nisl nisl aliquam nisl, eu aliquam nunc nisl euismod nisl.',
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
