import 'server_requester.dart';

import '../models/product.dart';

class RequestHandler {
  final ServerRequester _serverRequester = ServerRequester();

  // get the list of products
  Future<List<Product>> getProducts() async {
    List<Product> products = [];

    final Map<String, dynamic> data = await _serverRequester.get('/products');
    final List productsList = data['products'];

    for (Map m in productsList) {
      products.add(
        Product.fromMap(m),
      );
    }

    return products;
  }

  // login existing user
  Future<dynamic> login(
    String email,
    String password,
  ) async {
    final data = await _serverRequester.post('/login', {
      'email': email,
      'password': password,
    });

    return data;
  }

  // register a new user
  Future<dynamic> register(
    String email,
    String password1,
    String password2,
    bool hasMilitaryPassport,
  ) async {
    final data = await _serverRequester.post('/register', {
      'email': email,
      'password1': password1,
      'password2': password2,
      'hasMilitaryPassport': hasMilitaryPassport.toString(),
    });

    return data;
  }
}
