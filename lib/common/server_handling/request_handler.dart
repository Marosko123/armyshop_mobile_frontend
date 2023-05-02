// ignore_for_file: avoid_print

import 'dart:convert';

import '../../models/chat_room.dart';
import '../../models/message.dart';
import '../../models/user.dart';
import 'server_requester.dart';
import '../global_variables.dart';
import '../../models/product.dart';

class RequestHandler {
  // check connection to the server
  static Future<bool> checkConnection() async {
    final response = await ServerRequester.request(
      subUrl: '/ping',
      type: 'GET',
    );

    if (response['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  // get the list of products
  static Future<List<Product>> getProducts() async {
    List<Product> products = [];

    final Map<String, dynamic> data =
        await ServerRequester.request(subUrl: '/products', type: 'GET');

    final List productsList = data['products'] ?? [];

    for (Map m in productsList) {
      products.add(
        Product.fromMap(m),
      );
    }

    return products;
  }

  static Future<List<int>> getLikedProducts(int userId) async {
    List<int> likedProducts = [];

    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/liked_products/$userId',
        type: 'GET',
        token: GlobalVariables.token);

    // if (data['error'] != null) {
    //   throw data['error'];
    // }

    if (data['status'] != 200) return likedProducts; // no liked products

    final List productsList = data['products'];

    for (Map m in productsList) {
      likedProducts.add(
        m['product_id'],
      );
    }

    return likedProducts;
  }

  // add to liked products
  static Future<bool> addToLikedProducts(int userId, int productId) async {
    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/liked_products/$userId/$productId',
        type: 'POST',
        token: GlobalVariables.token);

    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  // remove from liked products
  static Future<bool> removeFromLikedProducts(int userId, int productId) async {
    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/liked_products/$userId/$productId',
        type: 'DELETE',
        token: GlobalVariables.token);

    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  // add to basket
  static Future<bool> addToBasket(
      int userId, int productId, int quantity) async {
    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/baskets/$userId/$productId/$quantity',
        type: 'POST',
        token: GlobalVariables.token);

    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  // remove from basket
  static Future<bool> removeFromBasket(int userId, int productId) async {
    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/baskets/$userId/$productId',
        type: 'DELETE',
        token: GlobalVariables.token);

    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  // get basket of user
  static Future<List<Map<String, dynamic>>> getBasket(int userId) async {
    final List<Map<String, dynamic>> products = [];
    print('object1');
    final Map<String, dynamic> data = await ServerRequester.request(
        subUrl: '/baskets/$userId', type: 'GET', token: GlobalVariables.token);
    print('object');
    if (data['status'] != 200) {
      return products; // no products in basket
    }

    final List<dynamic> productsList = data['products'];

    for (final Map<String, dynamic> m in productsList) {
      products.add({'product_id': m['product_id'], 'quantity': m['quantity']});
    }

    return products;
  }

  // get existing users
  static Future<dynamic> getUsers() async {
    final response = await ServerRequester.request(
        subUrl: '/users', type: 'GET', token: GlobalVariables.token);

    if (response['status'] == 200) {
      final usersList = response['users'];

      GlobalVariables.users = [];

      for (Map u in usersList) {
        GlobalVariables.users.add(
          User(
            id: u['id'],
            email: u['email'],
            firstName: u['first_name'] ?? '',
            lastName: u['last_name'] ?? '',
            age: u['age'] ?? 0,
            address: u['address'] ?? '',
            licensePicture: '',
            isLicenseValid: u['is_license_valid'] == 1,
            telephone: u['telephone'] ?? '',
            chatRooms: [],
          ),
        );
      }
    } else {
      return [];
    }

    return GlobalVariables.users;
  }

  // get user by id
  static Future<User> getUserById(int id) async {
    final response = await ServerRequester.request(
        subUrl: '/users/$id', type: 'GET', token: GlobalVariables.token);

    if (response['status'] == 200) {
      final Map u = response['user'];

      List<ChatRoom> chatRooms = [];

      for (var chatRoom in u['chat_rooms']) {
        chatRooms.add(ChatRoom(
          roomId: chatRoom['id'],
          creatorId: chatRoom['creator_id'],
          roomName: chatRoom['room_name'],
          members: jsonDecode(chatRoom['members']),
        ));
      }

      return User(
        id: u['id'],
        email: u['email'],
        firstName: u['first_name'] ?? '',
        lastName: u['last_name'] ?? '',
        age: u['age'] ?? 0,
        address: u['address'] ?? '',
        licensePicture: u['license_picture'] ?? '',
        isLicenseValid: u['is_license_valid'] == 1,
        telephone: u['telephone'] ?? '',
        chatRooms: chatRooms,
      );
    } else {
      return User(
        id: 0,
        email: '',
        firstName: '',
        lastName: '',
        age: 0,
        address: '',
        licensePicture: '',
        isLicenseValid: false,
        telephone: '',
        chatRooms: [],
      );
      ;
    }
  }

  // login existing user
  static Future<dynamic> login(
    String email,
    String password,
  ) async {
    final data = await ServerRequester.request(
      subUrl: '/login_user',
      type: 'POST',
      dataToSend: {
        'email': email,
        'password': password,
      },
    );

    return data;
  }

  // register a new user
  static Future<dynamic> register(
    String email,
    String password1,
    String password2,
    String militaryPassportBytes,
  ) async {
    final data = await ServerRequester.request(
      subUrl: '/register',
      type: 'POST',
      dataToSend: {
        'email': email,
        'password1': password1,
        'password2': password2,
        'license_picture': militaryPassportBytes,
      },
    );

    return data;
  }

  // create new chat room
  static Future<dynamic> getChatRooms() async {
    final data = await ServerRequester.request(
        subUrl: '/chat_rooms/${GlobalVariables.user.id}',
        type: 'GET',
        token: GlobalVariables.token);

    return data;
  }

  // create new chat room
  static Future<dynamic> createChatRoom(dynamic dataToSend) async {
    final data = await ServerRequester.request(
        subUrl: '/chat_rooms',
        type: 'POST',
        dataToSend: dataToSend,
        token: GlobalVariables.token);

    return data;
  }

  // get messages from room of user
  static Future<dynamic> getMessages(
      int userId, int roomId, bool getOnlyUnreadMessages) async {
    final data = await ServerRequester.request(
        subUrl: getOnlyUnreadMessages
            ? '/messages/unread/user/$userId/room/$roomId'
            : '/messages/user/$userId/room/$roomId',
        type: 'GET',
        token: GlobalVariables.token);

    if (data['error'] != null) {
      print(data['error']);
    }

    return data;
  }

  // get messages from room of user
  static Future<dynamic> sendMessage(Message message) async {
    final data = await ServerRequester.request(
        subUrl: '/messages',
        type: 'POST',
        dataToSend: {
          'sender_id': message.senderId,
          'room_id': message.roomId,
          'message': message.message,
        },
        token: GlobalVariables.token);

    if (data['error'] != null) {
      print(data['error']);
    }

    return data;
  }

  // get messages from room of user
  static Future<dynamic> updateUser(
      int id, String keySnakeCase, String value) async {
    final data = await ServerRequester.request(
        type: 'PATCH',
        subUrl: '/users/$id',
        dataToSend: {keySnakeCase: value},
        token: GlobalVariables.token);

    if (data['error'] != null) {
      print(data['error']);
    }

    return data;
  }
}
