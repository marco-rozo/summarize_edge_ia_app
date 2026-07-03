import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class SummaryAppBackground extends StatelessWidget {
  const SummaryAppBackground({
    super.key,
    this.child,
    this.gridSize = 32.0,
    this.showGrid = true,
    this.showGlows = true,
  });

  final Widget? child;

  /// The grid step size in logical pixels for the technical grid overlay.
  /// Defaults to 32px (matching `background-size: 32px 32px`).
  final double gridSize;

  /// Whether to render the technical grid overlay. Defaults to true.
  final bool showGrid;

  /// Whether to render the ambient LED radial glows. Defaults to true.
  final bool showGlows;

  @override
  Widget build(BuildContext context) {
    final Widget backgroundLayer = Positioned.fill(
      child: IgnorePointer(child: _buildBackgroundContent(context)),
    );

    if (child != null) {
      return Stack(children: [backgroundLayer, child!]);
    }

    return backgroundLayer;
  }

  Widget _buildBackgroundContent(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Container(color: AppColors.backgroundBase),
        Container(color: const Color(0xFF131313).withValues(alpha: 0.9)),
        if (showGlows) ...[
          Positioned(
            top: size.height * 0.20,
            left: -size.width * 0.10,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: size.width * 0.60,
                height: size.height * 0.60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.10,
            right: -size.width * 0.10,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                width: size.width * 0.50,
                height: size.height * 0.50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF2FD9F4).withValues(alpha: 0.08),
                      const Color(0xFF2FD9F4).withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ),
        ],
        if (showGrid)
          Positioned.fill(
            child: CustomPaint(
              painter: _TechGridPainter(
                gridSize: gridSize,
                lineColor: const Color(0xFFFFFFFF).withValues(alpha: 0.02),
              ),
            ),
          ),
      ],
    );
  }
}

class _TechGridPainter extends CustomPainter {
  const _TechGridPainter({required this.gridSize, required this.lineColor});

  final double gridSize;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (gridSize <= 0) return;

    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TechGridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize ||
        oldDelegate.lineColor != lineColor;
  }
}
