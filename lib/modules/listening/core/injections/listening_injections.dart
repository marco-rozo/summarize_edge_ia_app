import 'package:flutter_bloc/flutter_bloc.dart';

/// Centraliza os provedores de injeção de dependência do módulo [listening].
/// Segue o padrão arquitetural utilizando [RepositoryProvider] do flutter_bloc.
final class ListeningInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        // Futuros datasources, repositórios e usecases do módulo listening devem ser registrados aqui.
      ];
}
