import 'package:equatable/equatable.dart';

enum ChatMessageRole { user, assistant }

final class ChatMessageEntity extends Equatable {
  const ChatMessageEntity({
    required this.id,
    required this.content,
    required this.role,
    required this.sentAt,
  });

  final String id;
  final String content;
  final ChatMessageRole role;
  final DateTime sentAt;

  @override
  List<Object?> get props => [id, content, role, sentAt];
}
