class ChatMessageEntity {
  final String id;
  final String roomId;
  final String senderId;
  final String content;
  final bool isRead;
  final DateTime createdAt;
  final bool isMe;

  const ChatMessageEntity({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.isRead,
    required this.createdAt,
    required this.isMe,
  });
}
