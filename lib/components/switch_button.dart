import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isHighlighted;

  const SwitchButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isHighlighted});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: isHighlighted
              ? ArmyshopColors.switchButtonHighlighted
              : ArmyshopColors.switchButtonDisabled,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ArmyshopColors.switchButtonBorder,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: ArmyshopColors.textColor,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
