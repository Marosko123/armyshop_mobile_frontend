import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

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
      final products = jsonList
          .map((jsonProduct) =>
              Product.fromMap(jsonProduct as Map<String, dynamic>))
          .toList();
      return products;
    } catch (e) {
      // Handle the scenario where the app is not connected to the internet
      // and return the products from the serialized file
      final products = await _getOfflineProducts();
      return products;
    }
  }

  static Future<dynamic> get _localFile async {
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // construct a file path relative to the app's internal storage directory
    final documentsPath =
        path.join(appDir.path, "common", "documents", "products.json");

    // write data to the file at the documentsPath location
    final file = File(documentsPath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    return file;
  }

  static Future<List<Product>> _getOfflineProducts() async {
    final file = await _localFile;
    final json = await file.readAsString();
    final jsonList = jsonDecode(json) as List<dynamic>;
    final products = jsonList
        .map((jsonProduct) =>
            Product.fromMap(jsonProduct as Map<String, dynamic>))
        .toList();
    return products;
  }
}
