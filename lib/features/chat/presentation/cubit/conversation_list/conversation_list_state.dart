import 'package:equatable/equatable.dart';
import 'package:rentverse/features/chat/domain/entity/chat_conversation_entity.dart';

enum ConversationListStatus { initial, loading, success, failure }

class ConversationListState extends Equatable {
  final ConversationListStatus status;
  final List<ChatConversationEntity> conversations;
  final String? error;

  const ConversationListState({
    this.status = ConversationListStatus.initial,
    this.conversations = const [],
    this.error,
  });

  ConversationListState copyWith({
    ConversationListStatus? status,
    List<ChatConversationEntity>? conversations,
    String? error,
  }) {
    return ConversationListState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, conversations, error];
}
