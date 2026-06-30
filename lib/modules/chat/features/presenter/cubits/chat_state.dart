part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState({required this.messages});

  final List<ChatMessageEntity> messages;

  @override
  List<Object?> get props => [messages];
}

/// Estado padrão: aguardando input do usuário.
final class ChatIdle extends ChatState {
  const ChatIdle({required super.messages});
}

/// Estado transitório: mensagem enviada, aguardando resposta.
final class ChatSending extends ChatState {
  const ChatSending({required super.messages});
}
