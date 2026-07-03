import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/get_all_ai_models_usecase.dart';
import 'package:summary_app/modules/ai_models/features/presenter/cubits/ai_models_cubit.dart';
import 'package:summary_app/modules/ai_models/features/presenter/pages/ai_models_page.dart';

class AiModelsRoutes {
  static const String path = '/ai-models';

  static List<RouteBase> get routes => [
        GoRoute(
          path: path,
          builder: (context, state) {
            return BlocProvider<AiModelsCubit>(
              create: (context) => AiModelsCubit(
                getAllAiModelsUsecase: context.read<GetAllAiModelsUsecase>(),
                downloadAiModelUsecase: context.read<DownloadAiModelUsecase>(),
              )..fetchModels(),
              child: const AiModelsPage(),
            );
          },
        ),
      ];
}
