// ignore_for_file: prefer_initializing_formals
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/modules/ai_models/features/data/datasources/ai_model_datasource.dart';

class AiModelDatasourceImpl implements AiModelDatasource {
  final Dio _dio;
  final Logger _logger;

  AiModelDatasourceImpl({required Dio dio, Logger? logger})
    : _dio = dio,
      _logger = logger ?? Logger();

  @override
  Future<String> downloadModel({
    required String url,
    required String filePath,
  }) async {
    _logger.i('Iniciando download do modelo para: $filePath');

    int lastLoggedPercent = -1;
    // Realiza o download do modelo pesado via Dio e salva diretamente no disco
    await _dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final percent = ((received / total) * 100).floor();
          // Loga a porcentagem a cada 5% ou quando atinge 100%
          if ((percent % 5 == 0 || percent == 100) &&
              percent != lastLoggedPercent) {
            lastLoggedPercent = percent;
            _logger.i(
              'Download Qwen3-0.6B em progresso: $percent% ($received de $total bytes)',
            );
          }
        } else {
          _logger.i('Download em progresso: $received bytes recebidos');
        }
      },
      options: Options(responseType: ResponseType.bytes, followRedirects: true),
    );

    _logger.i(
      '✅ [SUCCESS] Download concluído com sucesso! Arquivo salvo no caminho:\n$filePath',
    );

    return filePath;
  }
}
