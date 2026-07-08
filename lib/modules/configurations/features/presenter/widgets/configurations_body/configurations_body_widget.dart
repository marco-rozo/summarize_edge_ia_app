import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/modules/ai_models/core/routes/ai_models_routes.dart';
import 'package:summary_app/modules/configurations/features/presenter/widgets/configurations_item/configurations_item_widget.dart';
import 'package:summary_app/modules/configurations/features/presenter/widgets/configurations_version_footer/configurations_version_footer_widget.dart';

/// The main content body of the Configurations page.
/// Shows a list of configuration items and a fixed version footer.
class ConfigurationsBodyWidget extends StatelessWidget {
  const ConfigurationsBodyWidget({super.key, required this.appVersion});

  final String appVersion;

  @override
  Widget build(BuildContext context) {
    final List<ConfigurationItemEntity> items = [
      const ConfigurationItemEntity(
        icon: Icons.delete_sweep_outlined,
        title: 'Apagar modelos baixados',
        subtitle: 'Remove todos os modelos de IA do dispositivo',
      ),
      ConfigurationItemEntity(
        icon: Icons.smart_toy_outlined,
        title: 'Gerenciar modelos de IA disponível',
        subtitle: 'Baixe, atualize ou remova modelos de IA',
        onTap: () => context.push(AiModelsRoutes.path),
      ),
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) =>
                ConfigurationsItemWidget(item: items[index]),
          ),
        ),

        // Fixed version footer
        ConfigurationsVersionFooterWidget(appVersion: appVersion),
      ],
    );
  }
}
