import 'package:rentverse/features/chat/data/source/chat_api_service.dart';
import 'package:rentverse/features/chat/domain/entity/chat_conversation_entity.dart';
import 'package:rentverse/features/chat/domain/entity/chat_message_entity.dart';
import 'package:rentverse/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiService _apiService;

  ChatRepositoryImpl(this._apiService);

  @override
  Future<String> startConversation(String propertyId) async {
    final response = await _apiService.startConversation(propertyId);
    return response.roomId;
  }

  @override
  Future<List<ChatConversationEntity>> getConversations() async {
    final conversations = await _apiService.getConversations();
    return conversations.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<ChatMessageEntity>> getMessages(
    String roomId, {
    required String currentUserId,
  }) async {
    final messages = await _apiService.getMessages(roomId);
    return messages
        .map((e) => e.toEntity(currentUserId: currentUserId))
        .toList();
  }

  @override
  Future<void> sendMessage(String roomId, String content) {
    return _apiService.sendMessage(roomId, content);
  }
}
