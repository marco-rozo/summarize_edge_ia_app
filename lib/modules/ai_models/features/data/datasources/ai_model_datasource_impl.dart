// ignore_for_file: prefer_initializing_formals
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/modules/ai_models/features/data/datasources/ai_model_datasource.dart';
import 'package:summary_app/modules/ai_models/features/data/models/ai_model_model.dart';

class AiModelDatasourceImpl implements AiModelDatasource {
  final Dio _dio;
  final FirebaseFirestore _firestore;
  final Logger _logger;

  AiModelDatasourceImpl({
    required Dio dio,
    FirebaseFirestore? firestore,
    Logger? logger,
  })  : _dio = dio,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _logger = logger ?? Logger();

  @override
  Future<List<AiModelModel>> getAllModels() async {
    _logger.i('Buscando modelos de IA no Firestore (coleção: ai_models)...');
    try {
      final snapshot = await _firestore.collection('ai_models').get();
      final models = snapshot.docs
          .map((doc) => AiModelModel.fromMap(doc.data(), doc.id))
          .toList();
      _logger.i('✅ [SUCCESS] ${models.length} modelos encontrados no Firestore.');
      return models;
    } catch (e, stackTrace) {
      _logger.e('Erro ao buscar modelos de IA no Firestore', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> downloadModel({
    required String url,
    required String filePath,
    void Function(int received, int total)? onProgress,
  }) async {
    _logger.i('Iniciando download do modelo para: $filePath');

    int lastLoggedPercent = -1;
    // Realiza o download do modelo pesado via Dio e salva diretamente no disco
    await _dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        onProgress?.call(received, total);
        if (total != -1) {
          final percent = ((received / total) * 100).floor();
          // Loga a porcentagem a cada 5% ou quando atinge 100%
          if ((percent % 5 == 0 || percent == 100) &&
              percent != lastLoggedPercent) {
            lastLoggedPercent = percent;
            _logger.i(
              'Download em progresso: $percent% ($received de $total bytes)',
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
