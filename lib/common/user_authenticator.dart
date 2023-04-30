import 'dart:convert';

import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';

import '../models/chat_room.dart';
import 'global_variables.dart';
import '../models/user.dart';

class UserAuthenticator {
  // Define a function to handle successful user login
  void userSuccessfullyLoggedIn(
      {required Map<String, dynamic> user, required BuildContext context}) {
    List<ChatRoom> chatRooms = [];

    for (var chatRoom in user['chat_rooms']) {
      chatRooms.add(ChatRoom(
        roomId: chatRoom['id'],
        creatorId: chatRoom['creator_id'],
        roomName: chatRoom['room_name'],
        members: jsonDecode(chatRoom['members']),
      ));
    }

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
      chatRooms: chatRooms,
    );
    
    // Navigate to the PrimaryPage and remove all previous routes from the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PrimaryPage()),
      (_) => false,
    );
  }

  static String getUserName(int id) {
    for (var user in GlobalVariables.users) {
      if (user.id == id) {
        return '${user.firstName} ${user.lastName}';
      }
    }

    return 'Unknown Unknown';
  }
}
