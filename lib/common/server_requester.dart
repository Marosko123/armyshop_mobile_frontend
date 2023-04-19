import 'dart:convert';
import 'package:http/http.dart' as http;

import 'global_variables.dart';

class ServerRequester {
  static const String _baseURL = 'http://127.0.0.1:8000/api';

  static Future<dynamic> request({
    required String subUrl,
    required String type,
    dynamic dataToSend,
  }) async {
    try {
      late http.Response response;

      switch (type) {
        case 'GET':
          response = await http.get(Uri.parse('$_baseURL$subUrl'));
          print(response.body);
          break;
        case 'POST':
          response = await http.post(
            Uri.parse('$_baseURL$subUrl'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(dataToSend),
          );
          break;
        case 'PUT':
        case 'PATCH':
          response = await http.patch(
            Uri.parse('$_baseURL$subUrl'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(dataToSend),
          );
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse('$_baseURL$subUrl'));
          break;
        default:
          return {'error': 'Invalid request type'};
      }

      GlobalVariables.isConnectedToServer = true;
      return json.decode(response.body);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      GlobalVariables.isConnectedToServer = false;
      // throw e;
      return {'error': 'Server is not responding'};
    }
  }
}
