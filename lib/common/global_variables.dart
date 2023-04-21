import 'dart:io';

import '../models/product.dart';
import '../models/user.dart';

class GlobalVariables {
  static String serverIP = Platform.isWindows
      ? '127.0.0.1'
      : '192.168.1.126'; // replace IP value with your server IP
  static List<Product> products = [];
  static List<User> users = [];
  static bool isConnectedToServer = true;
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
