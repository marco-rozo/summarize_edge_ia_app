import 'package:flutter_bloc/flutter_bloc.dart';

/// Centraliza os provedores de injeção de dependência do módulo [home].
/// Segue o padrão arquitetural utilizando [RepositoryProvider] do flutter_bloc.
final class HomeInjections {
  static List<RepositoryProvider> get repositoryProviders => [
        // No momento os dados são mockados diretamente no HomeCubit.
        // Futuros datasources, repositórios e usecases do módulo home devem ser registrados aqui.
      ];
}
