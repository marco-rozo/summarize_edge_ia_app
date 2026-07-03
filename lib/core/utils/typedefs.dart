import 'package:dartz/dartz.dart';
import 'package:summary_app/core/errors/failure.dart';

/// Typedef para encapsular os retornos dos UseCases e Repositories
/// na camada de Domínio via [Either] do dartz.
typedef Output<T> = Either<Failure, T>;
