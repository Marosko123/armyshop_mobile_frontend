import 'package:flutter/material.dart';

class ArmyshopColors {
  static bool isDarkMode = false;

  static late Color textColor;
  static late Color dropdownColor;
  static late Color dropdownContentColor;
  static late Color backgroundColor;
  static late Color dividerColor;
  static late Color buttonTextColor;
  static late Color buttonColor;
  static late Color textFieldFillColor;
  static late Color textFieldHintColor;
  static late Color chatBubbleColor;
  static late Color logoColor;
  static late Color switchButtonDisabled;
  static late Color switchButtonHighlighted;
  static late Color switchButtonBorder;
  static late Color shoppingCartItemBubble;

  static const Map<String, Color> lightColors = {
    "background": Color.fromARGB(255, 228, 227, 227),
    "dropdown": Color.fromARGB(255, 173, 173, 173),
    "dropdownContent": Color.fromARGB(255, 204, 204, 204),
    "text": Color.fromARGB(255, 0, 0, 0),
    "divider": Color.fromARGB(255, 158, 158, 158),
    "buttonText": Color.fromARGB(255, 255, 255, 255),
    "button": Color.fromARGB(255, 0, 0, 0),
    "textFieldFill": Color.fromARGB(255, 238, 238, 238),
    "textFieldHint": Color.fromARGB(255, 158, 158, 158),
    "chatBubble": Color.fromARGB(255, 0, 76, 138),
    "logo": Color.fromARGB(255, 4, 133, 0),
    "switchButtonDisabled": Color.fromARGB(255, 211, 211, 211),
    "switchButtonHighlighted": Color.fromARGB(255, 255, 255, 255),
    "switchButtonBorder": Color.fromARGB(255, 0, 0, 0),
    "shoppingCartItemBubble": Color.fromARGB(255, 145, 230, 48)
  };

  static const Map<String, Color> darkColors = {
    "background": Color.fromARGB(255, 0, 0, 0),
    "dropdown": Color.fromARGB(255, 85, 85, 85),
    "dropdownContent": Color.fromARGB(255, 100, 100, 100),
    "text": Color.fromARGB(255, 255, 255, 255),
    "divider": Color.fromARGB(255, 255, 255, 255),
    "buttonText": Color.fromARGB(255, 0, 0, 0),
    "button": Color.fromARGB(255, 255, 255, 255),
    "textFieldFill": Color.fromARGB(255, 112, 112, 112),
    "textFieldHint": Color.fromARGB(255, 241, 241, 241),
    "chatBubble": Color.fromARGB(255, 0, 153, 180),
    "logo": Color.fromARGB(255, 41, 204, 0),
    "switchButtonDisabled": Color.fromARGB(255, 0, 0, 0),
    "switchButtonHighlighted": Color.fromARGB(255, 90, 90, 90),
    "switchButtonBorder": Color.fromARGB(255, 255, 255, 255),
    "shoppingCartItemBubble": Color.fromARGB(255, 77, 117, 32)
  };

  static void setColors() {
    Map<String, Color> colors = isDarkMode ? darkColors : lightColors;

    ArmyshopColors.textColor = colors["text"]!;
    ArmyshopColors.dropdownColor = colors["dropdown"]!;
    ArmyshopColors.dropdownContentColor = colors["dropdownContent"]!;
    ArmyshopColors.backgroundColor = colors["background"]!;
    ArmyshopColors.dividerColor = colors["divider"]!;
    ArmyshopColors.buttonTextColor = colors["buttonText"]!;
    ArmyshopColors.buttonColor = colors["button"]!;
    ArmyshopColors.textFieldFillColor = colors["textFieldFill"]!;
    ArmyshopColors.textFieldHintColor = colors["textFieldHint"]!;
    ArmyshopColors.chatBubbleColor = colors["chatBubble"]!;
    ArmyshopColors.logoColor = colors["logo"]!;
    ArmyshopColors.switchButtonDisabled = colors["switchButtonDisabled"]!;
    ArmyshopColors.switchButtonHighlighted = colors["switchButtonHighlighted"]!;
    ArmyshopColors.switchButtonBorder = colors["switchButtonBorder"]!;
    ArmyshopColors.shoppingCartItemBubble = colors["shoppingCartItemBubble"]!;
  }

  static void changeColors(bool value) {
    isDarkMode = value;
    setColors();
  }
}
