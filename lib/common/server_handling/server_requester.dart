// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../global_variables.dart';

class ServerRequester {
  static final String _baseURL = 'http://${GlobalVariables.serverIP}:8000/api';

  static Future<dynamic> request(
      {required String subUrl,
      required String type,
      dynamic dataToSend,
      String? token}) async {
    try {
      late http.Response response;
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      switch (type) {
        case 'GET':
          response =
              await http.get(Uri.parse('$_baseURL$subUrl'), headers: headers);
          print(response.body);
          break;
        case 'POST':
          response = await http.post(
            Uri.parse('$_baseURL$subUrl'),
            headers: headers,
            body: jsonEncode(dataToSend),
          );
          break;
        case 'PUT':
        case 'PATCH':
          response = await http.patch(
            Uri.parse('$_baseURL$subUrl'),
            headers: headers,
            body: jsonEncode(dataToSend),
          );
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse('$_baseURL$subUrl'),
              headers: headers);
          break;
        default:
          return {'error': 'Invalid request type'};
      }

      GlobalVariables.isConnectedToServer = true;
      return json.decode(response.body);
    } catch (e) {
      print(e);
      GlobalVariables.isConnectedToServer = false;
      // throw e;
      return {'error': 'Server is not responding'};
    }
  }
}
