import '../models/product.dart';
import '../models/user.dart';

class GlobalVariables {
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
