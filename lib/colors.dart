import 'package:flutter/material.dart';

class ArmyshopColors {
  static bool isDarkMode = false;

  // Background color
  static const Color lightModeBackground = Color.fromARGB(255, 228, 227, 227);
  static const Color darkModeBackground = Color.fromARGB(255, 0, 0, 0);

  // Dropdown color
  static const Color lightModeDropdown = Color.fromARGB(255, 173, 173, 173);
  static const Color darkModeDropdown = Color.fromARGB(255, 36, 36, 36);

  // Dropdown content color
  static const Color lightModeDropdownContent =
      Color.fromARGB(255, 204, 204, 204);
  static const Color darkModeDropdownContent = Color.fromARGB(255, 63, 63, 63);

  // Text color
  static const Color lightModeText = Color.fromARGB(255, 0, 0, 0);
  static const Color darkModeText = Color.fromARGB(255, 255, 255, 255);

  // Variables
  static Color textColor = const Color.fromARGB(0, 0, 0, 0);
  static Color dropdownColor = const Color.fromARGB(0, 0, 0, 0);
  static Color dropdownContentColor = const Color.fromARGB(0, 0, 0, 0);
  static Color backgroundColor = const Color.fromARGB(0, 0, 0, 0);

  static void setColors() {
    textColor = isDarkMode ? darkModeText : lightModeText;
    dropdownColor = isDarkMode ? darkModeDropdown : lightModeDropdown;
    dropdownContentColor =
        isDarkMode ? darkModeDropdownContent : lightModeDropdownContent;
    backgroundColor = isDarkMode ? darkModeBackground : lightModeBackground;
  }

  static void changeColors(bool value) {
    isDarkMode = value;

    setColors();
  }
}
