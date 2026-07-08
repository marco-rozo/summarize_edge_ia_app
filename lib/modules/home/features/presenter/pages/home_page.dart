import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summary_app/modules/home/features/presenter/cubits/home_cubit.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/hero_section/hero_section_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_background/home_background_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_section_header/home_page_section_header_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_summaries_panel/home_page_summaries_panel_widget.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/home_view_more_button/home_page_view_more_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>()..init();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background decorativo isolado no fundo da Stack (já encapsulado em Positioned.fill internamente)
        const HomeBackgroundWidget(),

        // Conteúdo scrollável e barras na frente
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 48,
                bottom: 80,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      // Seção 1: Hero
                      const HeroSectionWidget(),
                      const SizedBox(height: 48),

                      // Seção 2: Últimos Resumos
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header da seção de resumos
                            const HomePageSectionHeaderWidget(),
                            const SizedBox(height: 20),

                            // Painel Glass com Lista de Resumos consome o HomeCubit
                            HomePageSummariesPanelWidget(cubit: _homeCubit),
                            const SizedBox(height: 24),

                            // Botão "Ver Mais"
                            const HomePageViewMoreButtonWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
