import 'dart:async';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../common/armyshop_colors.dart';
import '../common/request_handler.dart';
import '../models/chat_room.dart';
import '../models/message.dart';

class Chat extends StatefulWidget {
  final ChatRoom chatRoom;

  const Chat({Key? key, required this.chatRoom}) : super(key: key);

  static const routeName = '/chat';

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  late ChatRoom _chatRoom;
  late List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _chatRoom = widget.chatRoom;
    // _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
    //   getMessages();
    // });
    getMessages();
  }

  Future<void> getMessages() async {
    final response = await RequestHandler.getMessages(
        GlobalVariables.user.id, _chatRoom.roomId);

    if (response['status'] == 200) {
      _messages = [];

      for (var x in response['messages']) {
        _messages.add(Message(
          senderId: x['sender_id'],
          roomId: x['room_id'],
          message: x['message'],
          date: DateTime.fromMillisecondsSinceEpoch(x['date'] * 1000),
          isSentByMe: GlobalVariables.user.id == x['sender_id'],
        ));
      }
    }

    setState(() {});
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final message = Message(
      senderId: GlobalVariables.user.id,
      roomId: _chatRoom.roomId,
      message: text,
      date: DateTime.now(),
      isSentByMe: true,
    );

    dynamic response = await RequestHandler.sendMessage(message);

    if (response['status'] == 200) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
          response['message']['date'] * 1000);
      message.date = dateTime;
    }

    setState(() => _messages.add(message));
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
                      _chatRoom.roomName,
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
              elements: _messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (dynamic message) => SizedBox(
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
                  color: message.isSentByMe
                      ? ArmyshopColors.chatBubbleRightColor
                      : ArmyshopColors.chatBubbleLeftColor,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      message.message,
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
