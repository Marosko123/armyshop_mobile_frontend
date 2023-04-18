import 'server_requester.dart';
import 'global_variables.dart';
import '../models/product.dart';

class RequestHandler {
  // get the list of products
  static Future<List<Product>> getProducts() async {
    List<Product> products = [];

    final Map<String, dynamic> data =
        await ServerRequester.request(subUrl: '/products', type: 'GET');

    if (data['error'] != null) {
      throw data['error'];
    }

    final List productsList = data['products'];

    for (Map m in productsList) {
      products.add(
        Product.fromMap(m),
      );
    }

    return products;
  }

  // login existing user
  static Future<dynamic> getUsers() async {
    final data = await ServerRequester.request(
      subUrl: '/users',
      type: 'GET',
    );

    if (data['error'] != null) {
      throw data['error'];
    }

    return data;
  }

  // login existing user
  static Future<dynamic> login(
    String email,
    String password,
  ) async {
    final data = await ServerRequester.request(
      subUrl: '/login',
      type: 'POST',
      dataToSend: {
        'email': email,
        'password': password,
      },
    );

    if (data['error'] != null) {
      throw data['error'];
    }

    return data;
  }

  // register a new user
  static Future<dynamic> register(
    String email,
    String password1,
    String password2,
    bool hasMilitaryPassport,
  ) async {
    final data = await ServerRequester.request(
      subUrl: '/register',
      type: 'POST',
      dataToSend: {
        'email': email,
        'password1': password1,
        'password2': password2,
        'hasMilitaryPassport': hasMilitaryPassport.toString(),
      },
    );

    if (data['error'] != null) {
      throw data['error'];
    }

    return data;
  }

  // create new chat room
  static Future<dynamic> getChatRooms() async {
    final data = await ServerRequester.request(
      subUrl: '/chat_rooms/${GlobalVariables.user.id}',
      type: 'GET',
    );

    if (data['error'] != null) {
      throw data['error'];
    }

    return data;
  }

  // create new chat room
  static Future<dynamic> createChatRoom(dynamic dataToSend) async {
    final data = await ServerRequester.request(
      subUrl: '/chat_rooms',
      type: 'POST',
      dataToSend: dataToSend,
    );

    if (data['error'] != null) {
      throw data['error'];
    }

    return data;
  }
}
