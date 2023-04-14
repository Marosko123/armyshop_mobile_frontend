import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/numeric_step_button.dart';
import '../models/cart_model.dart';

class UserShoppingCart extends StatefulWidget {
  static const routeName = '/user-shopping-cart-screen';

  const UserShoppingCart({Key? key}) : super(key: key);

  @override
  UserShoppingCartState createState() => UserShoppingCartState();
}

class UserShoppingCartState extends State<UserShoppingCart> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        totalPrice = totalPrice;
      });
    });

    return Column(
      children: [
        if (totalPrice == 0)
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        Consumer<CartModel>(
          builder: (context, value, child) {
            totalPrice = 0;
            value.cartItems.forEach((item) {
              totalPrice += double.parse(item[1]) * item[2];
            });

            return Container(
              height: MediaQuery.of(context).size.height *
                  0.6, // Explicit height constraint
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Container(
                            height: 70, // provide a height constraint
                            child: Column(
                              children: const [
                                Icon(Icons.filter_outlined),
                              ],
                            ),
                          ),
                          subtitle: Container(
                            height: 70, // provide a height constraint
                            child: Column(
                              children: [
                                Text(
                                  value.cartItems[index][0],
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  value.cartItems[index][3],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                                const Text(
                                  'Price For One:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '\$${value.cartItems[index][1]}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NumericStepButton(
                                  maxValue: 20,
                                  defaultValue: value.cartItems[index][2],
                                  onChanged: (val) {
                                    value.cartItems[index][2] = val;
                                    setState(() {
                                      if (val == 0) {
                                        value.cartItems.removeAt(index);
                                      }
                                    });
                                  },
                                ),
                                const Text(
                                  'You Pay',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '\$${(double.parse(value.cartItems[index][1]) * value.cartItems[index][2]).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
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
                        style: TextStyle(color: Colors.green[100]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Pay Now
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green.shade100,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Text(
                          'Pay Now',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
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
