class ChatRoom {
  int roomId;
  int creatorId;
  String roomName;
  dynamic members;

  ChatRoom({
    required this.roomId,
    required this.creatorId,
    required this.roomName,
    required this.members,
  });
}
