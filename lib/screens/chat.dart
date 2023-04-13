import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../models/message.dart';

class Chat extends StatefulWidget {
  final String roomName;

  const Chat({Key? key, required this.roomName}) : super(key: key);

  static const routeName = '/chat';

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  String _roomName = '';
  TextEditingController _textController = TextEditingController();

  List<Message> messages = [
    Message(
        text: "Hello maj frend!",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Helo!",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: "2 + 2?",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Devat",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: "A ty kto?",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Ja nevjem us..",
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
  ];

  @override
  void initState() {
    super.initState();
    _roomName = widget.roomName; // Store the roomName value in the local field
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;

    final message = Message(
      text: text,
      date: DateTime.now(),
      isSentByMe: true,
    );

    setState(() => messages.add(message));
    _textController.clear();
  }

  void editChat() {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArmyshopColors.backgroundColor,
      body: Column(
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
                      _roomName,
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
                  onTap: editChat,
                  child: Icon(
                    Icons.settings,
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

          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: TextStyle(
                          color: ArmyshopColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  color: ArmyshopColors.chatBubbleColor,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: ArmyshopColors.textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: ArmyshopColors.textFieldFillColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Type a message',
                    ),
                    onSubmitted: (text) {
                      sendMessage(text);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
