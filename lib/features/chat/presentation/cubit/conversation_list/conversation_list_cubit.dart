import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/chat/domain/usecase/get_conversations_usecase.dart';
import 'package:rentverse/features/chat/presentation/cubit/conversation_list/conversation_list_state.dart';

class ConversationListCubit extends Cubit<ConversationListState> {
  ConversationListCubit(this._getConversations)
    : super(const ConversationListState());

  final GetConversationsUseCase _getConversations;

  Future<void> load() async {
    emit(state.copyWith(status: ConversationListStatus.loading, error: null));
    try {
      final conversations = await _getConversations();
      emit(
        state.copyWith(
          status: ConversationListStatus.success,
          conversations: conversations,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ConversationListStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
