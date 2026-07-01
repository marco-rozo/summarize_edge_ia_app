import 'package:logger/logger.dart';

abstract class Failure {
  final String? errorMessage;
  final StackTrace? stackTrace;
  final Logger _logger = Logger();

  Failure({this.errorMessage, this.stackTrace}) {
    _logger.e(
      'Unknown error occurred',
      error: errorMessage,
      stackTrace: stackTrace,
    );
  }

  String get userMessage;
}

class UnknownFailure extends Failure {
  UnknownFailure({super.errorMessage, super.stackTrace});

  @override
  String get userMessage => 'Ocorreu um erro inesperado. Tente novamente.';
}
