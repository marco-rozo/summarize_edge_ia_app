import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/router/app_named_routes.dart';
import 'package:summary_app/modules/chat/features/presenter/cubits/chat_cubit.dart';
import 'package:summary_app/modules/chat/features/presenter/pages/chat_page.dart';

final class ChatRoutes {
  ChatRoutes._();

  static List<GoRoute> get routes => [
        GoRoute(
          name: AppNamedRoutes.chat,
          path: AppNamedRoutes.chat,
          builder: (_, _) => BlocProvider<ChatCubit>(
            create: (_) => ChatCubit(),
            child: const ChatPage(),
          ),
        ),
      ];
}
