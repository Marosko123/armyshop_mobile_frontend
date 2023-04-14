import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ['Avocado', '4.00', Colors.green],
    ['Avocado', '4.00', Colors.green],
    ['Avocado', '4.00', Colors.green],
  ];

  final List _cartItems = [
    ['Avocado', '4.00', 1, 'lib/images/avocado.jpg', Colors.green],
    ['Melon', '12.00', 2, 'lib/images/avocado.jpg', Colors.red],
    ['Mango', '16.00', 3, 'lib/images/avocado.jpg', Colors.yellow],
  ];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double total = 0.0;

    for (var item in _cartItems) {
      total += double.parse(item[1]);
    }

    return total.toStringAsFixed(2);
  }
}
