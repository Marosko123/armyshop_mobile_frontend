// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/common/dialogs.dart';
import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/screens/payment_screeen.dart';
import 'package:flutter/material.dart';

import '../common/server_handling/request_handler.dart';
import '../components/numeric_step_button.dart';
import '../models/product.dart';
import '../models/product_with_quantity.dart';

class UserShoppingCart extends StatefulWidget {
  static const routeName = '/user-shopping-cart-screen';

  const UserShoppingCart({Key? key}) : super(key: key);

  @override
  UserShoppingCartState createState() => UserShoppingCartState();
}

class UserShoppingCartState extends State<UserShoppingCart> {
  double totalPrice = 0;
  List<Map<String, dynamic>> products = [];
  List<ProductWithQuantity> productsWithQuantity = [];
  List cartItems = [];
  int userId = GlobalVariables.user.id;
  String token = GlobalVariables.token;

  @override
  void initState() {
    super.initState();
    totalPrice = 0;
    getProducts();
  }

  void getProducts() async {
    products = await RequestHandler.getBasket(userId);
    List<Product> productsInBasket = GlobalVariables.products
        .where((product) =>
            products.any((item) => item['product_id'] == product.id))
        .toList();
    print('productsInBasket: ${productsInBasket.length}');
    for (var product in productsInBasket) {
      int quantity = products
          .firstWhere((item) => item['product_id'] == product.id)['quantity'];
      productsWithQuantity.add(ProductWithQuantity(product, quantity));
      totalPrice += product.price! * quantity;
    }

    populateCartItems();
  }

  // structure: ['name', 'price', 'quantity', 'image', 'id', 'license]
  void populateCartItems() {
    for (var productWithQuantity in productsWithQuantity) {
      final product = productWithQuantity.product;
      final quantity = productWithQuantity.quantity;
      final priceForOne = product.price!;
      final image = product.imageUrl!;
      final id = product.id!;
      final license = product.licenseNeeded!;

      cartItems.add([product.name, priceForOne, quantity, image, id, license]);
    }
    print("number of items: ${cartItems.length}");
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        totalPrice = totalPrice;
      });
    });

    if (totalPrice == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 250),
          Center(
            child: Text(
              'Your shopping cart is empty',
              style: TextStyle(
                color: ArmyshopColors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          // replace Consumer with Container
          height: MediaQuery.of(context).size.height *
              0.6, // Explicit height constraint
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: cartItems.length,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ArmyshopColors.shoppingCartItemBubble,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: SizedBox(
                        height: 70,
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network(
                            cartItems[index][3],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      subtitle: SizedBox(
                        height: 70,
                        child: Column(
                          children: [
                            Text(
                              cartItems[index][0],
                              style: TextStyle(
                                color: ArmyshopColors.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Price For One:',
                              style: TextStyle(
                                color: ArmyshopColors.textColor,
                                fontSize: 9,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              '\$${cartItems[index][1]}',
                              style: TextStyle(
                                color: ArmyshopColors.textColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NumericStepButton(
                            maxValue: 20,
                            defaultValue: cartItems[index][2],
                            onChanged: (val) {
                              // update quantity
                              if (cartItems[index][2] > val) {
                                RequestHandler.removeFromBasket(
                                    userId, cartItems[index][4]);
                              } else {
                                RequestHandler.addToBasket(
                                    userId, cartItems[index][4], 1);
                              }

                              cartItems[index][2] = val;

                              setState(() {
                                // update total price
                                totalPrice = 0;
                                for (var item in cartItems) {
                                  totalPrice += item[1] * item[2];
                                }
                                if (val == 0) {
                                  // remove from db
                                  RequestHandler.removeFromBasket(
                                      userId, cartItems[index][4]);
                                  cartItems.removeAt(index);
                                }
                              });
                            },
                          ),
                          Text(
                            'You Pay',
                            style: TextStyle(
                              color: ArmyshopColors.textColor,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '\$${(cartItems[index][1] * cartItems[index][2]).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: ArmyshopColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Total
        if (totalPrice != 0)
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(color: ArmyshopColors.textColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: ArmyshopColors.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Pay Now
                  GestureDetector(
                    onTap: () {
                      // check if license is needed to buy products
                      bool needsLicense = false;
                      String name = '';
                      for (var item in cartItems) {
                        if (item[5] == true) {
                          needsLicense = true;
                          name = item[0];
                        }
                      }
                      // check if user has license
                      if (needsLicense &&
                          !GlobalVariables.user.isLicenseValid) {
                        Dialogs.showPopup(context, 'License needed',
                            'You need a license to buy $name.');
                      } else {
                        Navigator.pushNamed(context, PaymentScreen.routeName);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ArmyshopColors.buttonColor,
                        border: Border.all(
                          color: ArmyshopColors.buttonTextColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Text(
                            'Pay Now',
                            style: TextStyle(
                                color: ArmyshopColors.buttonTextColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: ArmyshopColors.buttonTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
