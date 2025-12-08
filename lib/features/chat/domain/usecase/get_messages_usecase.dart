import 'package:rentverse/features/chat/domain/entity/chat_message_entity.dart';
import 'package:rentverse/features/chat/domain/repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Future<List<ChatMessageEntity>> call(
    String roomId, {
    required String currentUserId,
  }) {
    return _repository.getMessages(roomId, currentUserId: currentUserId);
  }
}
