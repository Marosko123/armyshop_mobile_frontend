import 'package:armyshop_mobile_frontend/colors.dart';
import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const Textfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: ArmyshopColors.textFieldFillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: ArmyshopColors.textFieldHintColor,
          ),
        ),
      ),
    );
  }
}
