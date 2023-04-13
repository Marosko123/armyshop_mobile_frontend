import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  static const routeName = '/chat-rooms';

  @override
  ChatRoomsState createState() => ChatRoomsState();
}

class ChatRoomsState extends State<ChatRooms> {
  List chatRooms = [1, 2, 3, 4, 5, 6];

  void openChatRoom(String roomName) {
    Navigator.of(context).pushNamed(Chat.routeName, arguments: roomName);
  }

  void createChatRoom() {
    // ignore: avoid_print
    print('Chat room added');
    chatRooms.add(chatRooms.length + 1);
    setState(() {
      chatRooms = chatRooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chatRoomButtons = [];

    for (var x in chatRooms) {
      chatRoomButtons.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: MyButton(
            text: 'Room $x',
            onTap: () => openChatRoom('Room $x'),
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
