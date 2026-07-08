import 'package:equatable/equatable.dart';

sealed class ConfigurationsState extends Equatable {
  const ConfigurationsState();
}

final class ConfigurationsInitial extends ConfigurationsState {
  const ConfigurationsInitial();

  @override
  List<Object?> get props => [];
}

final class ConfigurationsLoading extends ConfigurationsState {
  const ConfigurationsLoading();

  @override
  List<Object?> get props => [];
}

final class ConfigurationsSuccess extends ConfigurationsState {
  const ConfigurationsSuccess({required this.appVersion});

  final String appVersion;

  @override
  List<Object?> get props => [appVersion];
}
