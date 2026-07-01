import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

/// Edge Neural pulse/LED button.
///
/// States (controlled by [isActive]):
///   • **Active** — pulsing purple rings + full glow.  Represents AI processing.
///   • **Inactive** — static, dimmer button; same gradient but lower saturation.
///
/// The component also exposes a [ledColor] parameter so callers can override
/// the center dot color (e.g. use [AppColors.ledReady] for "model downloaded").
class MyAppPulseButton extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;
  final double sizeRatio;

  /// Overrides the icon/LED color. Defaults to white.
  final Color? ledColor;

  const MyAppPulseButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
    this.sizeRatio = 0.4,
    this.ledColor,
  });

  @override
  State<MyAppPulseButton> createState() => _MyAppPulseButtonState();
}

class _MyAppPulseButtonState extends State<MyAppPulseButton>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    if (widget.isActive) {
      _pulseController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant MyAppPulseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _pulseController.repeat();
    } else if (!widget.isActive && oldWidget.isActive) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double buttonSize = screenWidth * widget.sizeRatio;

    return SizedBox(
      width: buttonSize * 1.5,
      height: buttonSize * 1.5,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Outer pulse ring ──────────────────────────────────────────
            if (widget.isActive)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) => Container(
                  width: buttonSize * _pulseAnimation.value,
                  height: buttonSize * _pulseAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.ledProcessing
                          .withValues(alpha: _opacityAnimation.value * 0.5),
                      width: 2,
                    ),
                  ),
                ),
              ),
            // ── Mid pulse fill ────────────────────────────────────────────
            if (widget.isActive)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) => Container(
                  width: buttonSize * (_pulseAnimation.value * 0.85),
                  height: buttonSize * (_pulseAnimation.value * 0.85),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary
                        .withValues(alpha: _opacityAnimation.value * 0.12),
                  ),
                ),
              ),
            // ── Main button ───────────────────────────────────────────────
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(buttonSize / 2),
                splashColor: AppColors.primaryContainer.withValues(alpha: 0.25),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.isActive
                          ? [
                              AppColors.primary,          // #A855F7
                              AppColors.secondaryDark,    // #62259B
                            ]
                          : [
                              AppColors.surfaceContainerHigh,  // inactive — dim
                              AppColors.surfaceContainer,
                            ],
                    ),
                    // LED glow — 8px blur, 0.3 opacity per spec
                    boxShadow: [
                      BoxShadow(
                        color: widget.isActive
                            ? AppColors.primary.withValues(alpha: 0.30)
                            : AppColors.outline.withValues(alpha: 0.15),
                        blurRadius: widget.isActive ? 8 : 4,
                        spreadRadius: widget.isActive ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.ledColor ?? AppColors.white,
                    size: buttonSize * 0.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
