import 'package:flutter/material.dart';

class AuthState with ChangeNotifier {
  String _token = '';

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }
}