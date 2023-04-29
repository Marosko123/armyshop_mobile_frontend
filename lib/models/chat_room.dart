import 'package:armyshop_mobile_frontend/models/user.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'room_id': roomId,
      'creator_id': creatorId,
      'room_name': roomName,
      'members': members.map((user) => user.toMap()).toList(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      roomId: map['room_id'],
      creatorId: map['creator_id'],
      roomName: map['room_name'],
      members: List<User>.from(map['members'].map((user) => User.fromMap(user))),
    );
  }
}
