import 'dart:convert';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/common/request_handler.dart';
import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/models/chat_room.dart';
import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  static const routeName = '/chat-rooms';

  @override
  ChatRoomsState createState() => ChatRoomsState();
}

class ChatRoomsState extends State<ChatRooms> {
  late List chatRooms;
  String roomName = 'RUMKA';
  List<int> userIds = [1, 2, 3];

  @override
  void initState() {
    super.initState();

    chatRooms = GlobalVariables.user.chatRooms;
  }

  void openChatRoom(String roomName) {
    Navigator.of(context).pushNamed(Chat.routeName, arguments: roomName);
  }

  void createChatRoom() async {
    final response = await RequestHandler.createChatRoom({
      'creator_id': GlobalVariables.user.id,
      'room_name': roomName,
      'members': jsonEncode({'user_ids': userIds}),
    });

    print(response);

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
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chatRoomButtons = [];

    for (var x in chatRooms) {
      chatRoomButtons.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: MyButton(
            text: x.roomName,
            onTap: () => openChatRoom('Room ${x.roomName}'),
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
                      onTap: createChatRoom,
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
