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
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(0, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1)),
          child: Center(
              child: Text(text,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 16)))),
    );
  }
}
