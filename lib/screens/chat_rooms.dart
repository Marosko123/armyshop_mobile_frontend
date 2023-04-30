import 'dart:convert';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/common/request_handler.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/components/my_scroll_list.dart';
import 'package:armyshop_mobile_frontend/models/chat_room.dart';
import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';
import '../common/users_serializer.dart';
import '../models/user.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  static const routeName = '/chat-rooms';

  @override
  ChatRoomsState createState() => ChatRoomsState();
}

class ChatRoomsState extends State<ChatRooms> {
  late List<ChatRoom> chatRooms;
  String roomName = '';
  List<bool> isChecked = [];
  String error = 'Room name cannot be empty';
  bool dataInvalid = false;

  List<User> users = [];

  @override
  void initState() {
    super.initState();

    chatRooms = GlobalVariables.user.chatRooms;
  }

  void openChatRoom(ChatRoom chatRoom) {
    Navigator.of(context).pushNamed(Chat.routeName, arguments: chatRoom);
  }

  void createChatRoom(context) async {
    dynamic userIds = [];

    await showDialogAlert(context);

    if (dataInvalid || isChecked.isEmpty) {
      return;
    }

    for (int i = 0; i < isChecked.length; i++) {
      if (isChecked[i]) {
        userIds.add(users[i].id);
      }
    }

    final response = await RequestHandler.createChatRoom({
      'creator_id': GlobalVariables.user.id,
      'room_name': roomName,
      'members': jsonEncode({'user_ids': userIds}),
    });

    if (response['status'] == 200) {
      final chatRoom = response['chat_room'];

      GlobalVariables.user.chatRooms.add(ChatRoom(
        roomId: chatRoom['id'],
        creatorId: chatRoom['creator_id'],
        roomName: chatRoom['room_name'],
        members: jsonDecode(chatRoom['members']),
      ));

      setState(() {
        chatRooms = GlobalVariables.user.chatRooms;
      });
    }

    roomName = '';
    error = '';
    dataInvalid = false;
  }

  void validatePopupData(context) {
    if (roomName.isEmpty) {
      error = 'Room name cannot be empty';
      dataInvalid = true;
      setState(() {});
    } else {
      error = '';
      dataInvalid = false;
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  Future<void> showDialogAlert(BuildContext context) async {
    if(GlobalVariables.isConnectedToServer) {
      users = await RequestHandler.getUsers();
    } else {
      users = await UsersSerializer.deserialize();
    }

    if (users.isEmpty) {
      return;
    }

    users.removeWhere((user) => user.id == GlobalVariables.user.id);

    // ignore: use_build_context_synchronously
    return showDialog<void>(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ArmyshopColors.popupBackgroundColor,
          title: Text(
            'Create Chat Room',
            style: TextStyle(
              color: ArmyshopColors.popupTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Column(
                  children: [
                    Text(
                      'Room Name',
                      style: TextStyle(color: ArmyshopColors.popupTextColor),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ArmyshopColors.dividerColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: ArmyshopColors.popupTextColor),
                        onChanged: (value) {
                          roomName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                MyScrollList(
                    users: users, callback: (value) => isChecked = value),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                dataInvalid = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                validatePopupData(context);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chatRoomButtons = [];

    for (var room in chatRooms) {
      chatRoomButtons.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: MyButton(
            text: room.roomName,
            onTap: () => openChatRoom(room),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ArmyshopColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Header
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Chat Rooms',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ArmyshopColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if(GlobalVariables.isConnectedToServer) {
                          createChatRoom(context);
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: ArmyshopColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),

              Divider(
                color: ArmyshopColors.dividerColor,
                thickness: 1,
              ),

              Column(
                children: chatRoomButtons,
              )
            ],
          ),
        ),
      ),
    );
  }
}
