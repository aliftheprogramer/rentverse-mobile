import 'package:rentverse/features/chat/domain/repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Future<void> call(String roomId, String content) {
    return _repository.sendMessage(roomId, content);
  }
}
