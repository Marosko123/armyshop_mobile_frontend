import 'dart:convert';
import 'dart:io';

import '../../models/message.dart';

class MessageSerializer {
  static Future<void> serialize(List<Message> messages, int roomId) async {
    final jsonMessages = messages.map((message) => message.toMap()).toList();
    final json = jsonEncode(jsonMessages);
    final file = await _localFile(roomId);
    await file.writeAsString(json);
  }

  static Future<List<Message>> deserialize(int roomId) async {
    try {
      final file = await _localFile(roomId);
      final json = await file.readAsString();
      final jsonList = jsonDecode(json) as List<dynamic>;
      final messages = jsonList
          .map((jsonMessage) =>
              Message.fromMap(jsonMessage as Map<String, dynamic>))
          .toList();
      return messages;
    } catch (e) {
      // Handle the scenario where the app is not connected to the internet
      // and return the messages from the serialized file
      final messages = await _getOfflineMessages(roomId);
      return messages;
    }
  }

  static Future<File> _localFile(int roomId) async {
    final currentDirectory = Directory.current;
    final documentsDirectory =
        Directory('${currentDirectory.path}/lib/common/documents');
    final file = File('${documentsDirectory.path}/messages_$roomId.json');
    if (!await file.exists()) {
      await file.create();
    }
    return file;
  }

  static Future<List<Message>> _getOfflineMessages(int roomId) async {
    final file = await _localFile(roomId);
    final json = await file.readAsString();
    final jsonList = jsonDecode(json) as List<dynamic>;
    final messages = jsonList
        .map((jsonMessage) =>
            Message.fromMap(jsonMessage as Map<String, dynamic>))
        .toList();
    return messages;
  }
}
