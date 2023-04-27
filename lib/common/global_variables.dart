import 'dart:io';

import '../models/Product.dart';
import '../models/user.dart';

class GlobalVariables {
  static String serverIP = Platform.isWindows
      ? '127.0.0.1'
      : '10.10.67.222'; // replace IP value with your server IP
  static List<Product> products = [];
  static List<User> users = [];
  static bool isConnectedToServer = false;
  static User user = User(
    id: 1,
    email: 'admin@armyshop.xd',
    firstName: 'Adminko',
    lastName: 'Adminer',
    age: 99,
    address: 'FIIT STU',
    licensePicture: '',
    isLicenseValid: true,
    telephone: '911',
    chatRooms: [],
  );
}
