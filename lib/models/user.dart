import 'package:armyshop_mobile_frontend/common/server_handling/request_handler.dart';
import 'package:armyshop_mobile_frontend/models/chat_room.dart';

import '../common/converters.dart';

class User {
  final int id;
  String email;
  String firstName;
  String lastName;
  int age;
  String address;
  String licensePicture;
  bool isLicenseValid;
  String telephone;
  List<ChatRoom> chatRooms;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.licensePicture,
    required this.isLicenseValid,
    required this.telephone,
    required this.chatRooms,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'address': address,
      'license_picture': licensePicture,
      'isLicenseValid': isLicenseValid,
      'telephone': telephone,
      'chatRooms': chatRooms.map((room) => room.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      age: map['age'],
      address: map['address'],
      licensePicture: map['license_picture'],
      isLicenseValid: map['is_license_valid'] == 1,
      telephone: map['telephone'],
      chatRooms: List<ChatRoom>.from(
          map['chat_rooms']?.map((x) => ChatRoom.fromMap(x))),
    );
  }

  Future<dynamic> updateValue(String key, dynamic value) async {
    final String keyCamelCase = Converters.convertToCamelCase(key);
    final String keySnakeCase = Converters.convertToSnakeCase(key);

    final propertyMap = {
      'email': () => email = value,
      'firstName': () => firstName = value,
      'lastName': () => lastName = value,
      'age': () => age = value == "" ? 0 : int.parse(value),
      'address': () => address = value,
      'licensePicture': () => licensePicture = value,
      'isLicenseValid': () => isLicenseValid = value,
      'telephone': () => telephone = value,
      'password': () => null,
    };

    final setter = propertyMap[keyCamelCase];
    if (setter != null) {
      final response = await RequestHandler.updateUser(id, keySnakeCase, value);

      if (response['status'] == 200) {
        setter();
      }

      return response;
    }
  }

  isEmpty() {
    return email == '';
  }
}
