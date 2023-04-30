import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.text, required this.onTap});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: ArmyshopColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: text != 'Chat With Us' ||
                (!GlobalVariables.user.isEmpty() && text == 'Chat With Us')
            ? Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: ArmyshopColors.buttonTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: ArmyshopColors.buttonTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
