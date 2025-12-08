class StartChatResponseModel {
  final String roomId;

  const StartChatResponseModel({required this.roomId});

  factory StartChatResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final roomId = (data['roomId'] ?? data['room_id'] ?? data['id'] ?? '')
        .toString();
    return StartChatResponseModel(roomId: roomId);
  }
}
