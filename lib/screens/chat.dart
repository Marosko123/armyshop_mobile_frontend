import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../models/message.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
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
                        style: const TextStyle(color: Colors.white),
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
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade400,
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Type a message',
              ),
              onSubmitted: (text) {
                final message = Message(
                  text: text,
                  date: DateTime.now(),
                  isSentByMe: true,
                );

                setState(() => messages.add(message));
              },
            ),
          ),
        ],
      ),
    );
  }
}
