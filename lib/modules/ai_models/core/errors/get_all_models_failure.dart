import 'package:summary_app/core/errors/failure.dart';

/// Falha específica para erros ocorridos ao buscar a lista de modelos de IA no Firestore.
class GetAllModelsFailure extends Failure {
  GetAllModelsFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage =>
      'Não foi possível carregar a lista de modelos de IA. Verifique sua conexão com a internet e tente novamente.';
}
