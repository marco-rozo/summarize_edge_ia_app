import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_bottom_sheet/summary_app_bottom_sheet.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/components/summary_app_text_button/summary_app_text_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';
import 'package:summary_app/modules/components/core/routes/components_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage>
    with SummaryAppBottomSheet {
  final _whiteLine = const SizedBox(height: 8);
  bool _isDownloading = false;

  Future<void> _downloadAiModel() async {
    setState(() {
      _isDownloading = true;
    });

    const url =
        'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2FQwen3-0.6B.litertlm?alt=media&token=e9a427dc-6836-4aac-8464-6a2782f74341';
    const fileName = 'Qwen3-0.6B.litertlm';

    final usecase = context.read<DownloadAiModelUsecase>();
    final result = await usecase(url: url, fileName: fileName);

    if (!mounted) return;

    setState(() {
      _isDownloading = false;
    });

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.userMessage),
            backgroundColor: AppColors.negative,
          ),
        );
      },
      (path) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Modelo salvo com sucesso em:\n$path'),
            backgroundColor: AppColors.primary,
          ),
        );
      },
    );
  }

  void _showBlurredBottomSheet() {
    showSummaryAppBlurredBottomSheet(
      context,
      showDragHandle: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.blur_on_rounded,
            size: 48,
            color: AppColors.primaryLight,
          ),
          _whiteLine,
          Text(
            'Blurred Bottom Sheet',
            style: AppTextStyle.headlineMd.copyWith(color: AppColors.onSurface),
            textAlign: TextAlign.center,
          ),
          _whiteLine,
          Text(
            'Efeito glassmorphism com desfoque de fundo (blur 20px).',
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          _whiteLine,
          SummaryAppButton.primary(
            text: 'Fechar',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showStandardBottomSheet() {
    showSummaryAppBottomSheet(
      context: context,
      initialChildSize: 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.layers_rounded,
            size: 48,
            color: AppColors.primaryLight,
          ),
          _whiteLine,
          Text(
            'Standard Bottom Sheet',
            style: AppTextStyle.headlineMd.copyWith(color: AppColors.onSurface),
            textAlign: TextAlign.center,
          ),
          _whiteLine,
          Text(
            'Modal padrão com suporte a DraggableScrollableSheet do design system.',
            style: AppTextStyle.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          _whiteLine,
          SummaryAppButton.secondary(
            text: 'Fechar',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Componentes Compartilhados')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edge Neural Design System',
              style: AppTextStyle.headlineMd.copyWith(
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            _whiteLine,
            Text(
              'Galeria focada estritamente nos componentes compartilhados de core/theme/components.',
              style: AppTextStyle.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            _buildSectionTitle('SummaryAppButton (Variações & Estados)'),
            SummaryAppButton.primary(
              text: 'Primário (LED Purple)',
              leftIcon: Icons.bolt_rounded,
              onPressed: () {},
            ),
            _whiteLine,
            SummaryAppButton.secondary(
              text: 'Secundário (Ghost / Borda)',
              leftIcon: Icons.layers_outlined,
              onPressed: () {},
            ),
            _whiteLine,
            SummaryAppButton.tertiaryBorder(
              text: 'Terciário (Borda Sutil)',
              leftIcon: Icons.tune_rounded,
              onPressed: () {},
            ),
            _whiteLine,
            SummaryAppButton.tertiaryFill(
              text: 'Terciário Preenchido',
              leftIcon: Icons.tune_rounded,
              onPressed: () {},
            ),
            _whiteLine,
            SummaryAppButton.negative(
              text: 'Negativo (Ação Destrutiva)',
              leftIcon: Icons.delete_outline_rounded,
              onPressed: () {},
            ),
            _whiteLine,
            const SummaryAppButton.primary(
              text: 'Estado Desabilitado',
              onPressed: null,
            ),
            _whiteLine,
            SummaryAppButton.secondary(
              text: 'Estado Carregando',
              isLoading: true,
              onPressed: () {},
            ),
            _whiteLine,
            SummaryAppTextButton(
              text: 'TextButton Habilitado (com ícone)',
              leftIcon: Icons.info_outline_rounded,
              onPressed: () {},
            ),
            _whiteLine,
            const SummaryAppTextButton(
              text: 'TextButton Desabilitado',
              leftIcon: Icons.block_rounded,
              onPressed: null,
            ),
            _buildSectionTitle('BottomSheets'),
            SummaryAppButton.secondary(
              text: 'Abrir Blurred Bottom Sheet',
              leftIcon: Icons.blur_on_rounded,
              onPressed: _showBlurredBottomSheet,
            ),
            _whiteLine,
            SummaryAppButton.tertiaryBorder(
              text: 'Abrir Standard Bottom Sheet',
              leftIcon: Icons.layers_rounded,
              onPressed: _showStandardBottomSheet,
            ),
            _buildSectionTitle('Backgrounds'),
            SummaryAppButton.secondary(
              text: 'Show Background 1',
              leftIcon: Icons.route_rounded,
              onPressed: () =>
                  context.push(ComponentsRoutes.backgroundTestPath),
            ),
            _buildSectionTitle('Download Modelo IA (Qwen3-0.6B)'),
            SummaryAppButton.primary(
              text: _isDownloading
                  ? 'Baixando Modelo IA...'
                  : 'Baixar Qwen3-0.6B (LiteRT)',
              leftIcon: Icons.cloud_download_rounded,
              isLoading: _isDownloading,
              onPressed: _isDownloading ? null : _downloadAiModel,
            ),
            _buildSectionTitle('Módulos & Fluxos do App'),
            SummaryAppButton.secondary(
              text: 'Ir para Onboarding',
              leftIcon: Icons.explore_rounded,
              onPressed: () => context.push(OnboardingRoutes.path),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          title,
          style: AppTextStyle.labelMd.copyWith(color: AppColors.primaryLight),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
