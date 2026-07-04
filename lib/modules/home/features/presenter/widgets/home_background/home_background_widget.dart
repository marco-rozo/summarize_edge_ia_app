import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/components/summary_app_background/summary_app_background.dart';

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Utiliza o componente compartilhado SummaryAppBackground para desenhar
    // o fundo escuro, os glows (círculos esfumaçados roxo e azul) com ImageFilter.blur
    // e a grade (grid) decorativa.
    return const SummaryAppBackground(
      showGlows: true,
      showGrid: true,
    );
  }
}
