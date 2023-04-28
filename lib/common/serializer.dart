import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/Product.dart';

// Code to serialize and deserialize products

class Serializer {
  static Future<void> serialize(List<Product> products) async {
    final jsonProducts = products.map((product) => product.toMap()).toList();
    final json = jsonEncode(jsonProducts);
    final file = await _localFile;
    await file.writeAsString(json);
  }

  static Future<List<Product>> deserialize() async {
    try {
      final file = await _localFile;
      final json = await file.readAsString();
      final jsonList = jsonDecode(json) as List<dynamic>;
      final products = jsonList.map((jsonProduct) => Product.fromMap(jsonProduct as Map<String, dynamic>)).toList();
      return products;
    } catch (e) {
      // Handle the scenario where the app is not connected to the internet
      // and return the products from the serialized file
      final products = await _getOfflineProducts();
      return products;
    }
  }

  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'products.json');
    final file = File(path);
    if (!await file.exists()) {
      await file.create();
    }
    return file;
  }

  static Future<List<Product>> _getOfflineProducts() async {
    final file = await _localFile;
    final json = await file.readAsString();
    final jsonList = jsonDecode(json) as List<dynamic>;
    final products = jsonList.map((jsonProduct) => Product.fromMap(jsonProduct as Map<String, dynamic>)).toList();
    return products;
  }
}

