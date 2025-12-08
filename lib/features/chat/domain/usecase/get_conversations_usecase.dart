import 'package:rentverse/features/chat/domain/entity/chat_conversation_entity.dart';
import 'package:rentverse/features/chat/domain/repository/chat_repository.dart';

class GetConversationsUseCase {
  final ChatRepository _repository;

  GetConversationsUseCase(this._repository);

  Future<List<ChatConversationEntity>> call() {
    return _repository.getConversations();
  }
}
