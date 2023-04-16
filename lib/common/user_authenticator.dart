import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';

import 'global_variables.dart';
import '../models/user.dart';

class UserAuthenticator {
  // Define a function to handle successful user login
  void userSuccessfullyLoggedIn(
      {required Map<String, dynamic> user, required BuildContext context}) {
    // Set the values of the user instance based on the returned map
    GlobalVariables.user = User(
      id: user['id'],
      email: user['email'],
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      age: user['age'] ?? 0,
      address: user['address'] ?? '',
      licensePicture: user['license_picture'] ?? '',
      isLicenseValid: user['is_license_valid'] == 1,
      telephone: user['telephone'] ?? '',
    );

    // Navigate to the PrimaryPage and remove all previous routes from the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PrimaryPage()),
      (_) => false,
    );
  }
}
