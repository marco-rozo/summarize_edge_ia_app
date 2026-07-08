import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:summary_app/modules/configurations/features/presenter/cubits/configurations_state.dart';

class ConfigurationsCubit extends Cubit<ConfigurationsState> {
  ConfigurationsCubit() : super(const ConfigurationsInitial());

  Future<void> init() async {
    emit(const ConfigurationsLoading());
    final String version = await _getCurrentAppVersion();
    emit(ConfigurationsSuccess(appVersion: version));
  }

  Future<String> _getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
