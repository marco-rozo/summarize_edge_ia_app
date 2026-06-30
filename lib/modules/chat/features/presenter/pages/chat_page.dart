import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/my_app_chat_bubble/my_app_chat_bubble.dart';
import 'package:summary_app/core/theme/components/my_app_chat_input/my_app_chat_input.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/chat/features/domain/entities/chat_message_entity.dart';
import 'package:summary_app/modules/chat/features/presenter/cubits/chat_cubit.dart';
import 'package:summary_app/modules/chat/features/presenter/widgets/chat_empty_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ChatCubit>();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightSecondary,
      appBar: _ChatAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatCubit, ChatState>(
                  bloc: _cubit,
                  listenWhen: (previous, current) =>
                      previous.messages.length != current.messages.length,
                  listener: (_, _) => _scrollToBottom(),
                  builder: (_, state) {
                    final List<ChatMessageEntity> messages = state.messages;

                    if (messages.isEmpty) {
                      return const ChatEmptyWidget();
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (_, index) => MyAppChatBubble(
                        message: messages[index],
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<ChatCubit, ChatState>(
                bloc: _cubit,
                builder: (_, state) => MyAppChatInput(
                  isLoading: state is ChatSending,
                  onSend: _cubit.sendMessage,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leadingWidth: 48,
      titleSpacing: 0,
      leading: const BackButton(color: AppColors.white),
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.secondary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Assistente',
                style: AppTextStyle.appBarTitle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.positive,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Online',
                    style: AppTextStyle.chatTimestamp.copyWith(
                      color: AppColors.backgroundLightTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
