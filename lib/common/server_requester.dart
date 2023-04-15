
// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerRequester {
  final String _baseURL = 'http://127.0.0.1:8000/api';

  Future<dynamic> get(String subUrl) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL$subUrl'),
      );

      return json.decode(response.body);
    } catch (e) {
      print('Server Get Error: $e');
      rethrow;
    }
  }

  Future<dynamic> post(String subUrl, dynamic dataToSend) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseURL$subUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(dataToSend),
      );

      return json.decode(response.body);
    } catch (e) {
      print('Server Post Error: $e');
      rethrow;
    }
  }
}
