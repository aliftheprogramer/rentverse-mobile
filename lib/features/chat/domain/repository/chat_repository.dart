import 'package:rentverse/features/chat/domain/entity/chat_conversation_entity.dart';
import 'package:rentverse/features/chat/domain/entity/chat_message_entity.dart';

abstract class ChatRepository {
  Future<String> startConversation(String propertyId);
  Future<List<ChatConversationEntity>> getConversations();
  Future<List<ChatMessageEntity>> getMessages(
    String roomId, {
    required String currentUserId,
  });
  Future<void> sendMessage(String roomId, String content);
}
