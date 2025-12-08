import 'package:rentverse/features/chat/domain/repository/chat_repository.dart';

class StartChatUseCase {
  final ChatRepository _repository;

  StartChatUseCase(this._repository);

  Future<String> call(String propertyId) {
    return _repository.startConversation(propertyId);
  }
}
