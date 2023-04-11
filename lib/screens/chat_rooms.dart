import 'package:armyshop_mobile_frontend/components/my_button.dart';
import 'package:armyshop_mobile_frontend/screens/chat.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  static const routeName = '/chat-rooms';

  @override
  ChatRoomsState createState() => ChatRoomsState();
}

class ChatRoomsState extends State<ChatRooms> {
  List chatRooms = [1, 2, 3, 4, 5, 6];

  void openChatRoom() {
    Navigator.of(context).pushNamed(Chat.routeName);
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
          child: MyButton(text: 'Room $x', onTap: openChatRoom),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Header
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Chat Rooms',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: createChatRoom,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Colors.grey,
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
