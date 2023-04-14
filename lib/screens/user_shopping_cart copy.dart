import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class UserShoppingCart extends StatefulWidget {
  static const routeName = '/user-shopping-cart-screen';

  const UserShoppingCart({super.key});

  @override
  UserShoppingCartState createState() => UserShoppingCartState();
}

class UserShoppingCartState extends State<UserShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.account_circle_outlined,
          color: Colors.green[700],
          size: MediaQuery.of(context).size.width * 0.4,
        ),

        Consumer<CartModel>(
          builder: (context, value, child) {
            return Container(
              height: MediaQuery.of(context).size.height *
                  0.4, // Explicit height constraint
              child: ListView.builder(
                itemCount: value.cartItems.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                          leading: const Icon(Icons.filter_outlined),
                          title: Text(value.cartItems[index][0]),
                          subtitle: Text('\$' + value.cartItems[index][1]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .removeItemFromCart(index);
                            },
                          )),
                    ),
                  );
                },
              ),
            );
          },
        ),

        // Total
        Padding(
          padding: const EdgeInsets.all(36.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(24),
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
                      // '\$' + value.calculateTotal(),
                      '4',
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
