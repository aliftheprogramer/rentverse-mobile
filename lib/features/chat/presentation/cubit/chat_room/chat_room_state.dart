import 'package:equatable/equatable.dart';
import 'package:rentverse/features/chat/domain/entity/chat_message_entity.dart';

enum ChatRoomStatus { initial, loading, success, failure }

class ChatRoomState extends Equatable {
  final ChatRoomStatus status;
  final String? roomId;
  final List<ChatMessageEntity> messages;
  final bool sending;
  final String? error;

  const ChatRoomState({
    this.status = ChatRoomStatus.initial,
    this.roomId,
    this.messages = const [],
    this.sending = false,
    this.error,
  });

  ChatRoomState copyWith({
    ChatRoomStatus? status,
    String? roomId,
    List<ChatMessageEntity>? messages,
    bool? sending,
    String? error,
  }) {
    return ChatRoomState(
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      sending: sending ?? this.sending,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, roomId, messages, sending, error];
}
