import 'package:summary_app/core/utils/typedefs.dart';

abstract class DownloadAiModelUsecase {
  Future<Output<String>> call({required String url, required String fileName});
}
