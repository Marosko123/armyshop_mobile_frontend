import 'dart:convert';


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
    if (map.isEmpty) {
      return ChatRoom(
        roomId: -1,
        creatorId: 0,
        roomName: '',
        members: [],
      );
    }

    List<int> members = [];
    if (map['members'] != null) {
      members = List<int>.from(json.decode(map['members'])['user_ids']);
    }
    return ChatRoom(
      roomId: map['id'],
      creatorId: map['creator_id'],
      roomName: map['room_name'],
      members: members
    );
  }
}
