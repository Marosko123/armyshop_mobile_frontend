import 'package:armyshop_mobile_frontend/colors.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/chat_rooms.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'login_register_screen.dart';

class UserAccount extends StatefulWidget {
  final Function callback;
  static const routeName = '/user-account-screen';

  const UserAccount({Key? key, required this.callback}) : super(key: key);

  @override
  UserAccountState createState() => UserAccountState();
}

class UserAccountState extends State<UserAccount> {
  String loremIpsum =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ';
  bool isLoggedIn = false;

  void openChatRoom() {
    Navigator.of(context).pushNamed(ChatRooms.routeName);
  }

  void darkmodeChanged(bool value) {
    setState(() {
      ArmyshopColors.changeColors(value);
    });

    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        Icons.account_circle_outlined,
        color: Colors.green[700],
        size: MediaQuery.of(context).size.width * 0.4,
      ),

      // space between icon and name
      const SizedBox(height: 20),

      if (isLoggedIn)
        Text(
          'Ferko Mrkvicka',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ArmyshopColors.textColor,
          ),
        ),

      if (!isLoggedIn) ...[
        Text(
          'You are not logged in',
          style: TextStyle(
            fontSize: 20,
            color: ArmyshopColors.textColor,
          ),
        ),
        const SizedBox(height: 20),
        MyButton(
          text: 'Login',
          onTap: () {
            Navigator.of(context).pushNamed(LoginRegisterScreen.routeName);
          },
        ),
      ],

      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ArmyshopColors.dropdownColor,
          ),
          child: ExpandablePanel(
            header: Container(
              decoration: BoxDecoration(color: ArmyshopColors.dropdownColor),
              child: Padding(
                padding: const EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ArmyshopColors.textColor,
                  ),
                ),
              ),
            ),
            collapsed: const Text(''),
            expanded: Container(
              decoration: BoxDecoration(
                color: ArmyshopColors.dropdownContentColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(
                          'Darkmode:',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 18,
                            color: ArmyshopColors.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Switch(
                          value: ArmyshopColors
                              .isDarkMode, // Current value of the switch (true for Dark mode, false for Light mode)
                          onChanged: (value) {
                            darkmodeChanged(value);
                          },
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
            builder: (_, collapsed, expanded) =>
                Expandable(collapsed: collapsed, expanded: expanded),
          ),
        ),
      ),

      if (isLoggedIn)
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ArmyshopColors.dropdownColor,
            ),
            child: ExpandablePanel(
              header: Container(
                decoration: BoxDecoration(color: ArmyshopColors.dropdownColor),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 15),
                  child: Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ),
              ),
              collapsed: const Text(''),
              expanded: Container(
                decoration: BoxDecoration(
                  color: ArmyshopColors.dropdownContentColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    List.generate(5, (_) => loremIpsum).join('\n\n'),
                    style: TextStyle(
                      fontSize: 18,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ),
              ),
              builder: (_, collapsed, expanded) =>
                  Expandable(collapsed: collapsed, expanded: expanded),
            ),
          ),
        ),

      if (isLoggedIn)
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ArmyshopColors.dropdownColor,
            ),
            child: ExpandablePanel(
              header: Container(
                decoration: BoxDecoration(
                  color: ArmyshopColors.dropdownColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 15),
                  child: Text(
                    'Help',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ),
              ),
              collapsed: const Text(''),
              expanded: Container(
                decoration: BoxDecoration(
                  color: ArmyshopColors.dropdownContentColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Write us an email:',
                        style: TextStyle(
                          fontSize: 18,
                          color: ArmyshopColors.textColor,
                        ),
                      ),
                      Text(
                        'support@armyshop.xd',
                        style: TextStyle(
                          fontSize: 18,
                          color: ArmyshopColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 18,
                          color: ArmyshopColors.textColor,
                        ),
                      ),
                      MyButton(text: 'Chat with us', onTap: openChatRoom),
                    ],
                  ),
                ),
              ),
              builder: (_, collapsed, expanded) =>
                  Expandable(collapsed: collapsed, expanded: expanded),
            ),
          ),
        ),
    ]);
  }
}
