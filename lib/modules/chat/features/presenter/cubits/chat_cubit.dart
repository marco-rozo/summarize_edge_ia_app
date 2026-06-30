import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/modules/chat/features/domain/entities/chat_message_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatIdle(messages: []));

  void sendMessage(String content) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;

    final currentMessages = switch (state) {
      ChatIdle(:final messages) => messages,
      ChatSending(:final messages) => messages,
    };

    final userMessage = ChatMessageEntity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      content: trimmed,
      role: ChatMessageRole.user,
      sentAt: DateTime.now(),
    );

    emit(ChatSending(messages: [...currentMessages, userMessage]));

    // Simulação: confirma entrega sem resposta real do LLM por enquanto.
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isClosed) {
        emit(ChatIdle(messages: (state as ChatSending).messages));
      }
    });
  }
}
