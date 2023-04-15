import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';

import 'global_variables.dart';
import '../models/user.dart';

class UserAuthenticator {
  void userSuccessfullyLoggedIn(user, context) {
    GlobalVariables.user = User(
      id: user['id'],
      email: user['email'],
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      age: user['age'] ?? 0,
      address: user['address'] ?? '',
      licensePicture: user['license_picture'] ?? '',
      isLicenseValid: user['is_license_valid'] == 1 ? true : false,
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PrimaryPage()),
      (route) => false,
    );
  }
}
