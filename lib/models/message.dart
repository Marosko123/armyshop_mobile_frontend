class Message {
  late int senderId;
  late int roomId;
  late String message;
  late DateTime date;
  late bool isSentByMe;

  Message({
    required this.senderId,
    required this.roomId,
    required this.message,
    required this.date,
    required this.isSentByMe,
  });
}
