// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'global_variables.dart';

class ServerRequester {
  static final String _baseURL = 'http://${GlobalVariables.serverIP}:8000/api';

  static Future<dynamic> request({
  required String subUrl,
  required String type,
  dynamic dataToSend,
  String? token,
}) async {
  try {
    late http.Response response;

    switch (type) {
      case 'GET':
        response = await http.get(Uri.parse('$_baseURL$subUrl'), headers: _headers(token));
        print(response.body);
        break;
      case 'POST':
        response = await http.post(
          Uri.parse('$_baseURL$subUrl'),
          headers: _headers(token),
          body: jsonEncode(dataToSend),
        );
        break;
      case 'PUT':
      case 'PATCH':
        response = await http.patch(
          Uri.parse('$_baseURL$subUrl'),
          headers: _headers(token),
          body: jsonEncode(dataToSend),
        );
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse('$_baseURL$subUrl'), headers: _headers(token));
        break;
      default:
        return {'error': 'Invalid request type'};
    }

    GlobalVariables.isConnectedToServer = true;
    return json.decode(response.body);
  } catch (e) {
    print(e);
    GlobalVariables.isConnectedToServer = false;
    return {'error': 'Server is not responding'};
  }
}

static Map<String, String>? _headers(String? token) {
  if (token == null) return null;
  return <String, String>{'Authorization': 'Bearer $token'};
}

}
