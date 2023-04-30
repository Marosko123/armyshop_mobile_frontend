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

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'roomId': roomId,
      'message': message,
      'date': date.toIso8601String(),
      'isSentByMe': isSentByMe,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as int,
      roomId: map['roomId'] as int,
      message: map['message'] as String,
      date: DateTime.parse(map['date'] as String),
      isSentByMe: map['isSentByMe'] as bool,
    );
  }
}
