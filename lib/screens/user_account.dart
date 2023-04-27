import 'dart:convert';

import 'package:armyshop_mobile_frontend/common/armyshop_colors.dart';
import 'package:armyshop_mobile_frontend/common/request_handler.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/components/my_textfield.dart';
import 'package:armyshop_mobile_frontend/screens/chat_rooms.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import '../models/chat_room.dart';
import '../models/user.dart';
import 'login_register/login_register_screen.dart';

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

  Future<void> openChatRooms() async {
    dynamic response = await RequestHandler.getChatRooms();

    if (response['status'] == 200) {
      List<ChatRoom> chatRooms = [];

      for (var chatRoom in response['chat_rooms']) {
        chatRooms.add(ChatRoom(
          roomId: chatRoom['id'],
          creatorId: chatRoom['creator_id'],
          roomName: chatRoom['room_name'],
          members: jsonDecode(chatRoom['members']),
        ));
      }

      GlobalVariables.user.chatRooms = chatRooms;
    }

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
    return Column(
      children: [
        if (!GlobalVariables.user.isEmpty()) ...[
          Icon(
            Icons.account_circle_sharp,
            color: Colors.green[700],
            size: MediaQuery.of(context).size.width * 0.4,
          ),

          // space between icon and name
          const SizedBox(height: 20),

          Text(
            GlobalVariables.user.firstName == '' ||
                    GlobalVariables.user.lastName == ''
                ? GlobalVariables.user.email
                : '${GlobalVariables.user.firstName} ${GlobalVariables.user.lastName}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ArmyshopColors.textColor,
            ),
          ),
        ] else ...[
          Container(
            height: 270,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ArmyshopColors.dropdownColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    'You are not logged in',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: Text(
                    'Log in to:',
                    style: TextStyle(
                      fontSize: 16,
                      color: ArmyshopColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Show products that fit you the best',
                        style: TextStyle(
                          fontSize: 14,
                          color: ArmyshopColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '• Save unfinished orders',
                        style: TextStyle(
                          fontSize: 14,
                          color: ArmyshopColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '• Show list of your liked items',
                        style: TextStyle(
                          fontSize: 14,
                          color: ArmyshopColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                MyButton(
                  text: 'Log In',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(LoginRegisterScreen.routeName);
                  },
                ),
              ],
            ),
          )
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
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: AbsorbPointer(
            absorbing: GlobalVariables.user.isEmpty(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ArmyshopColors.dropdownColor,
              ),
              child: ExpandablePanel(
                header: Container(
                  decoration:
                      BoxDecoration(color: ArmyshopColors.dropdownColor),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ArmyshopColors.textColor,
                            ),
                          ),
                          if (GlobalVariables.user.isEmpty())
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      )),
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
                        MyTextfield(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: GlobalVariables.user.email,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.password,
                          label: 'Password',
                          value: '********',
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.text_fields_outlined,
                          label: 'First Name',
                          value: GlobalVariables.user.firstName,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.text_fields_outlined,
                          label: 'Last Name',
                          value: GlobalVariables.user.lastName,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.numbers_outlined,
                          label: 'Age',
                          value: GlobalVariables.user.age.toString(),
                          isNumeric: true,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: GlobalVariables.user.address,
                          isAddress: true,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                        MyTextfield(
                          icon: Icons.phone_outlined,
                          label: 'Telephone',
                          value: GlobalVariables.user.telephone,
                          saveCallback: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (_, collapsed, expanded) =>
                    Expandable(collapsed: collapsed, expanded: expanded),
              ),
            ),
          ),
        ),
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
                      MyButton(text: 'Chat with us', onTap: openChatRooms),
                    ],
                  ),
                ),
              ),
              builder: (_, collapsed, expanded) =>
                  Expandable(collapsed: collapsed, expanded: expanded),
            ),
          ),
        ),
        if (!GlobalVariables.user.isEmpty())
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
            child: MyButton(
              text: 'Log Out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ArmyshopColors.backgroundColor,
                    title: Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        color: ArmyshopColors.textColor,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          GlobalVariables.user = User(
                            id: 0,
                            email: '',
                            firstName: '',
                            lastName: '',
                            age: 0,
                            address: '',
                            licensePicture: '',
                            isLicenseValid: false,
                            telephone: '',
                            chatRooms: [],
                          );
                          GlobalVariables.isUserLoggedIn = false;
                          setState(() {});
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
