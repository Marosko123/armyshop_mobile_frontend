import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ['Avocado', '4.00', Colors.green],
    ['Avocado', '4.00', Colors.green],
    ['Avocado', '4.00', Colors.green],
  ];

  final List _cartItems = [
    ['Comfy jacket', '55.00', 5, 'Clothing/Jackets'],
    ['Karambit', '32.00', 2, 'Weapons/Knives'],
    ['Machinegun', '100.00', 1, 'Weapons/Heavy'],
    ['Socks', '1.00', 5, 'Clothing/Socks'],
    ['Ak47', '256.00', 2, 'Weapons/Rifles'],
    ['Shield', '100.00', 2, 'Weapons/Heavy'],
    ['Glasses', '5.00', 6, 'Accessories/Glasses'],
    ['Hat', '12.00', 2, 'Clothing/Hats'],
    ['Bazooka', '100.00', 1, 'Explosives'],
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
