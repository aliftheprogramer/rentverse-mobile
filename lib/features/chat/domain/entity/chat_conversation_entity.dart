class ChatConversationEntity {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String propertyCity;
  final String otherUserName;
  final String? otherUserAvatar;
  final String lastMessage;
  final DateTime lastMessageAt;

  const ChatConversationEntity({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyCity,
    required this.otherUserName,
    required this.otherUserAvatar,
    required this.lastMessage,
    required this.lastMessageAt,
  });
}
