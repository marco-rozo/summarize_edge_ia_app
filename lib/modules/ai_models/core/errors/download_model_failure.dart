import 'package:summary_app/core/errors/failure.dart';

/// Falha específica para erros ocorridos durante o download de modelos de IA.
class DownloadModelFailure extends Failure {
  DownloadModelFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage =>
      'Não foi possível realizar o download do modelo de IA. Verifique sua conexão e tente novamente.';
}
