import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class OnboardingBackgroundDecoration extends StatelessWidget {
  const OnboardingBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.sizeOf(context).height * 0.20,
              left: -MediaQuery.sizeOf(context).width * 0.10,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  height: MediaQuery.sizeOf(context).height * 0.50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -MediaQuery.sizeOf(context).height * 0.20,
              right: -MediaQuery.sizeOf(context).width * 0.10,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.50,
                  height: MediaQuery.sizeOf(context).height * 0.50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.tertiary.withValues(alpha: 0.08),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: const SizedBox.shrink(),
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.20,
                child: CustomPaint(painter: _GridPainter()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0x05FFFFFF)
      ..strokeWidth = 1;

    const double step = 48;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
