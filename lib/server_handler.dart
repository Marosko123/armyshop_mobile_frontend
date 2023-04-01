// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/Product.dart';

class ServerHandler {
  final String _baseURL = 'http://127.0.0.1:8000/api';

  // get the list of products
  Future<List<Product>> getProducts() async {
    try {
      List<Product> products = [];

      http.Response response = await http.get(Uri.parse('$_baseURL/products'));
      print(response.body);

      final Map<String, dynamic> data = (json.decode(response.body));

      final List productsList = data['products'];

      for (Map m in productsList) {
        products.add(Product.fromMap(m));
      }

      return products;
    } catch (e) {
      print('Server Handler Error: $e');
      rethrow;
    }
  }
}
