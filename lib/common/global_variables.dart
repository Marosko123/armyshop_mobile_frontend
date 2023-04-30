import 'dart:io';

import '../models/Product.dart';
import '../models/user.dart';

class GlobalVariables {
  static String serverIP = Platform.isWindows
      ? '127.0.0.1'
      : '147.175.161.191'; // replace IP value with your server IP
  static List<Product> products = [];
  static List<User> users = [];
  static bool isConnectedToServer = false;
  static bool isUserLoggedIn = true;
  static String token = '';
  static User user = User(
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
  static dynamic tmpData = {
    'email': '',
    'password1': '',
    'password2': '',
    'previousScreen': '',
    'picture': '',
  };
}
