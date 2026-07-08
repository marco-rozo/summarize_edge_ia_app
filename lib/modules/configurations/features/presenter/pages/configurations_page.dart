import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';
import 'package:summary_app/core/theme/components/summary_app_bar/summary_app_bar.dart';
import 'package:summary_app/modules/configurations/features/presenter/cubits/configurations_cubit.dart';
import 'package:summary_app/modules/configurations/features/presenter/cubits/configurations_state.dart';
import 'package:summary_app/modules/configurations/features/presenter/widgets/configurations_body/configurations_body_widget.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({super.key});

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  late final ConfigurationsCubit _configurationsCubit;

  @override
  void initState() {
    super.initState();
    _configurationsCubit = context.read<ConfigurationsCubit>()..init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      extendBodyBehindAppBar: true,
      appBar: const SummaryAppBar(title: 'Configurações'),
      body: SummaryAppBackground(
        child: SafeArea(
          child: BlocBuilder<ConfigurationsCubit, ConfigurationsState>(
            bloc: _configurationsCubit,
            builder: (context, state) {
              if (state is ConfigurationsSuccess) {
                return ConfigurationsBodyWidget(
                  appVersion: state.appVersion,
                );
              }

              // Loading / Initial
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
