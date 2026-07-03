abstract class AiModelDatasource {
  Future<String> downloadModel({required String url, required String filePath});
}
