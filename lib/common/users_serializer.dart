import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

class UsersSerializer {
  static Future<void> serialize(List<User> users) async {
    final jsonUsers = users.map((user) => user.toJson()).toList();
    final json = jsonEncode(jsonUsers);
    final file = await _localFile();
    await file.writeAsString(json);
  }

  static Future<List<User>> deserialize() async {
    final file = await _localFile();
    final json = await file.readAsString();
    final jsonList = jsonDecode(json) as List<dynamic>;
    final users = jsonList.map((jsonUser) => User.fromMap(jsonUser as Map<String, dynamic>)).toList();
    return users;
  }

  static Future<File> _localFile() async {
    final currentDirectory = Directory.current;
    final documentsDirectory = Directory('${currentDirectory.path}/lib/common/documents');
    final file = File('${documentsDirectory.path}/users.json');
    if (!await file.exists()) {
      await file.create();
    }
    return file;
  }
}
