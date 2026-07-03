import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_app_bottom_sheet/summary_app_bottom_sheet.dart';
import 'package:summary_app/core/theme/components/summary_app_button/summary_app_button.dart';
import 'package:summary_app/core/theme/components/summary_app_text_button/summary_app_text_button.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';
import 'package:summary_app/modules/ai_models/features/data/models/ai_model_model.dart';
import 'package:summary_app/modules/ai_models/features/domain/usecases/download_ai_model_usecase.dart';
import 'package:summary_app/modules/ai_models/core/routes/ai_models_routes.dart';
import 'package:summary_app/modules/components/core/routes/components_routes.dart';
import 'package:summary_app/modules/onboarding/core/routes/onboarding_routes.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage>
    with SummaryAppBottomSheet {
  @override
  void initState() {
    super.initState();
  }

  // TODO REMOVER APÓS SALVAR REALMENTE
  Future<void> popularModelosNoFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('ai_models');

    final aiModelsToRegister = [
      // ---------------------------------------------------------
      // MODELOS ASR (AUDIO-TO-TEXT)
      // ---------------------------------------------------------
      const AiModelModel(
        id: '',
        name: 'Whisper Base (30s)',
        description:
            'Modelo de transcrição acústica (ASR) padrão ouro. Extrai o texto com alta precisão a partir de áudios brutos de até 30 segundos.',
        fileName: 'whisper_base_30s_f32.tflite',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2Fwhisper_base_30s_f32.tflite?alt=media&token=93a7bf23-1bfd-4d02-b471-7ae76011640d',
        sizeInBytes: 290082636,
        version: '1.0.0',
        parameterCount: '72.6M',
        taskType: 'audio-to-text',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Qwen 3 ASR (5s)',
        description:
            'Modelo acústico otimizado (Quantizado Int8). Transcreve áudio de forma extremamente veloz usando processamento em fatias de 5 segundos.',
        fileName: 'qwen3_asr_0.6b_5s_i8.tflite',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2Fqwen3_asr_0.6b_5s_i8.tflite?alt=media&token=2d02c90e-7428-4a32-9827-d61cd959e53a',
        sizeInBytes: 793931296,
        version: '1.0.0',
        parameterCount: '0.9B',
        taskType: 'audio-to-text',
        isActive: true,
      ),

      // ---------------------------------------------------------
      // MODELOS LLM (TEXT-TO-TEXT)
      // ---------------------------------------------------------
      const AiModelModel(
        id: '',
        name: 'Gemma 3 (1.0B Instruct)',
        description:
            'Modelo avançado para estruturação de dados. Lê a transcrição e organiza as ações concluídas de forma rápida e inteligente.',
        fileName: 'Gemma3-1B-IT_multi-prefill-seq_q4_ekv4096.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2FGemma3-1B-IT_multi-prefill-seq_q4_ekv4096.litertlm?alt=media&token=4ecc0930-cf7f-4054-8270-a546eefe8ebf',
        sizeInBytes: 584417280,
        version: '1.0.0',
        parameterCount: '1.0B',
        taskType: 'text-to-text',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Qwen 2 (0.5B Instruct)',
        description:
            'Modelo LLM ultraleve. Focado em consumo mínimo de bateria e respostas diretas para rotinas simples.',
        fileName: 'Qwen2_0.5B_Instruct.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2FQwen2_0.5B_Instruct.litertlm?alt=media&token=31bdf1bf-6fef-46f2-945a-f2aeaf30797c',
        sizeInBytes: 647377840,
        version: '1.0.0',
        parameterCount: '0.5B',
        taskType: 'text-to-text',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Qwen 2.5 (1.5B Instruct)',
        description:
            'O motor mais capaz do catálogo. Alta capacidade de raciocínio para extrair detalhes complexos e classificar históricos textuais com extrema precisão.',
        fileName: 'Qwen2.5-1.5B-Instruct_multi-prefill-seq_q8_ekv4096.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2FQwen2.5-1.5B-Instruct_multi-prefill-seq_q8_ekv4096.litertlm?alt=media&token=c5e61ccd-e798-436a-936b-5bd6af3edf5f',
        sizeInBytes: 1597931520,
        version: '1.0.0',
        parameterCount: '2B',
        taskType: 'text-to-text',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Qwen 3 (0.6B)',
        description:
            'Modelo Qwen leve com 0.6 bilhões de parâmetros, ideal para tarefas gerais de texto.',
        fileName: 'Qwen3-0.6B.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2FQwen3-0.6B.litertlm?alt=media&token=e9a427dc-6836-4aac-8464-6a2782f74341',
        sizeInBytes: 614236160,
        parameterCount: '0.6B',
        taskType: 'text-to-text',
        version: '1.0.0',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Gemma 3 (270M Instruct)',
        description:
            'Modelo Gemma 3 compactado em 8-bits, focado em seguir instruções e chat.',
        fileName: 'gemma3-270m-it-q8.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2Fgemma3-270m-it-q8.litertlm?alt=media&token=ac437d90-2728-441f-b852-c7d9c34b16b1',
        sizeInBytes: 304005120,
        parameterCount: '270M',
        taskType: 'text-to-text',
        version: '1.0.0',
        isActive: true,
      ),
      const AiModelModel(
        id: '',
        name: 'Tiny Garden (Q8)',
        description:
            'Modelo ultracompacto Tiny Garden, focado em baixo consumo de memória.',
        fileName: 'tiny_garden_q8_ekv1024.litertlm',
        downloadUrl:
            'https://firebasestorage.googleapis.com/v0/b/summary-ia-app.firebasestorage.app/o/models%2Ftiny_garden_q8_ekv1024.litertlm?alt=media&token=bb9922d0-1c78-46e4-8254-cbcfc396361d',
        sizeInBytes: 288964608,
        parameterCount: '270M',
        taskType: 'text-to-text',
        version: '1.0.0',
        isActive: true,
      ),
    ];

    final Logger logger = Logger();

    for (var modelo in aiModelsToRegister) {
      try {
        await collection.add(modelo.toMap());
        logger.i('✅ Modelo ${modelo.name} cadastrado com sucesso!');
      } catch (e) {
        logger.e(e);
      }
    }

    logger.i('🚀 Todos os modelos foram cadastrados no Firestore!');
  }

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
            _whiteLine,
            SummaryAppButton.secondary(
              text: 'Ir para Modelos de IA',
              leftIcon: Icons.psychology_rounded,
              onPressed: () => context.push(AiModelsRoutes.path),
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
