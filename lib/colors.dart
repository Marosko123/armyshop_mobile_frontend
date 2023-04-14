import 'package:flutter/material.dart';

class ArmyshopColors {
  static bool isDarkMode = false;

  // Background color
  static const Color lightModeBackground = Color.fromARGB(255, 228, 227, 227);
  static const Color darkModeBackground = Color.fromARGB(255, 0, 0, 0);
  // Dropdown color
  static const Color lightModeDropdown = Color.fromARGB(255, 173, 173, 173);
  static const Color darkModeDropdown = Color.fromARGB(255, 85, 85, 85);
  // Dropdown content color
  static const Color lightModeDropdownContent =
      Color.fromARGB(255, 204, 204, 204);
  static const Color darkModeDropdownContent =
      Color.fromARGB(255, 100, 100, 100);
  // Text color
  static const Color lightModeText = Color.fromARGB(255, 0, 0, 0);
  static const Color darkModeText = Color.fromARGB(255, 255, 255, 255);
  // Divider color
  static const Color lightModeDivider = Color.fromARGB(255, 158, 158, 158);
  static const Color darkModeDivider = Color.fromARGB(255, 255, 255, 255);
  // Button color
  static const Color lightModeButton = Color.fromARGB(255, 0, 0, 0);
  static const Color darkModeButton = Color.fromARGB(255, 255, 255, 255);
  // Button text color
  static const Color lightModeButtonText = Color.fromARGB(255, 255, 255, 255);
  static const Color darkModeButtonText = Color.fromARGB(255, 0, 0, 0);
  // Text field fill color
  static const Color lightModeTextFieldFill =
      Color.fromARGB(255, 238, 238, 238);
  static const Color darkModeTextFieldFill = Color.fromARGB(255, 112, 112, 112);
  // Text field hint color
  static const Color lightModeTextFieldHint =
      Color.fromARGB(255, 158, 158, 158);
  static const Color darkModeTextFieldHint = Color.fromARGB(255, 241, 241, 241);
  // Chat bubble color
  static const Color lightModeChatBubble = Color.fromARGB(255, 0, 76, 138);
  static const Color darkModeChatBubble = Color.fromARGB(255, 0, 153, 180);
  // Logo color
  static const Color lightModeLogo = Color.fromARGB(255, 4, 133, 0);
  static const Color darkModeLogo = Color.fromARGB(255, 41, 204, 0);
  // Switch button color
  static const Color lightModeSwitchButtonDisabled =
      Color.fromARGB(255, 211, 211, 211);
  static const Color darkModeSwitchButtonDisabled =
      Color.fromARGB(255, 0, 0, 0);
  // Switch button highlighted color
  static const Color lightModeSwitchButtonHighlighted =
      Color.fromARGB(255, 255, 255, 255);
  static const Color darkModeSwitchButtonHighlighted =
      Color.fromARGB(255, 90, 90, 90);
  // Switch button border color
  static const Color lightModeSwitchButtonBorder = Color.fromARGB(255, 0, 0, 0);
  static const Color darkModeSwitchButtonBorder =
      Color.fromARGB(255, 255, 255, 255);
  // Shopping cart item bubble
  static const Color lightModeShoppingCartItemBubble =
      Color.fromARGB(255, 145, 230, 48);
  static const Color darkModeShoppingCartItemBubble =
      Color.fromARGB(255, 77, 117, 32);

  // Variables
  static Color textColor = const Color.fromARGB(0, 0, 0, 0);
  static Color dropdownColor = const Color.fromARGB(0, 0, 0, 0);
  static Color dropdownContentColor = const Color.fromARGB(0, 0, 0, 0);
  static Color backgroundColor = const Color.fromARGB(0, 0, 0, 0);
  static Color dividerColor = const Color.fromARGB(0, 0, 0, 0);
  static Color buttonTextColor = const Color.fromARGB(0, 0, 0, 0);
  static Color buttonColor = const Color.fromARGB(0, 0, 0, 0);
  static Color textFieldFillColor = const Color.fromARGB(0, 0, 0, 0);
  static Color textFieldHintColor = const Color.fromARGB(0, 0, 0, 0);
  static Color chatBubbleColor = const Color.fromARGB(0, 0, 0, 0);
  static Color logoColor = const Color.fromARGB(0, 0, 0, 0);
  static Color switchButtonDisabled = const Color.fromARGB(0, 0, 0, 0);
  static Color switchButtonHighlighted = const Color.fromARGB(0, 0, 0, 0);
  static Color switchButtonBorder = const Color.fromARGB(0, 0, 0, 0);
  static Color shoppingCartItemBubble = const Color.fromARGB(0, 0, 0, 0);

  static void setColors() {
    textColor = isDarkMode ? darkModeText : lightModeText;
    dropdownColor = isDarkMode ? darkModeDropdown : lightModeDropdown;
    dropdownContentColor =
        isDarkMode ? darkModeDropdownContent : lightModeDropdownContent;
    backgroundColor = isDarkMode ? darkModeBackground : lightModeBackground;
    dividerColor = isDarkMode ? darkModeDivider : lightModeDivider;
    buttonTextColor = isDarkMode ? darkModeButtonText : lightModeButtonText;
    buttonColor = isDarkMode ? darkModeButton : lightModeButton;
    textFieldFillColor =
        isDarkMode ? darkModeTextFieldFill : lightModeTextFieldFill;
    textFieldHintColor =
        isDarkMode ? darkModeTextFieldHint : lightModeTextFieldHint;
    chatBubbleColor = isDarkMode ? darkModeChatBubble : lightModeChatBubble;
    logoColor = isDarkMode ? darkModeLogo : lightModeLogo;
    switchButtonDisabled = isDarkMode
        ? darkModeSwitchButtonDisabled
        : lightModeSwitchButtonDisabled;
    switchButtonHighlighted = isDarkMode
        ? darkModeSwitchButtonHighlighted
        : lightModeSwitchButtonHighlighted;
    switchButtonBorder =
        isDarkMode ? darkModeSwitchButtonBorder : lightModeSwitchButtonBorder;
    shoppingCartItemBubble = isDarkMode
        ? darkModeShoppingCartItemBubble
        : lightModeShoppingCartItemBubble;
  }

  static void changeColors(bool value) {
    isDarkMode = value;

    setColors();
  }
}
