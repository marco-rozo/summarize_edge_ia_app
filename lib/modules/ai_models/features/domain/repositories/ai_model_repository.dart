import 'package:summary_app/core/utils/typedefs.dart';

abstract class AiModelRepository {
  Future<Output<String>> downloadModel({
    required String url,
    required String filePath,
  });
}
