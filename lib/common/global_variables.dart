import '../models/product.dart';
import '../models/user.dart';

class GlobalVariables {
  static List<Product> products = [];
  static bool isConnectedToServer = true;
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
  );
}
