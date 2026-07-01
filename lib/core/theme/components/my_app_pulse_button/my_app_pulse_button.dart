import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class MyAppPulseButton extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;
  final double sizeRatio;

  const MyAppPulseButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
    this.sizeRatio = 0.4,
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
            // Pulse ring 1 (outer)
            if (widget.isActive)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (_, _) => Container(
                  width: buttonSize * _pulseAnimation.value,
                  height: buttonSize * _pulseAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary
                          .withValues(alpha: _opacityAnimation.value * 0.5),
                      width: 3,
                    ),
                  ),
                ),
              ),
            // Pulse ring 2 (mid)
            if (widget.isActive)
              AnimatedBuilder(
                animation: _pulseController,
                builder: (_, _) => Container(
                  width: buttonSize * (_pulseAnimation.value * 0.92),
                  height: buttonSize * (_pulseAnimation.value * 0.92),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary
                        .withValues(alpha: _opacityAnimation.value * 0.15),
                  ),
                ),
              ),
            // Main button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(buttonSize / 2),
                splashColor: AppColors.secondaryLight.withValues(alpha: 0.3),
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
                              AppColors.primary,
                              AppColors.secondary,
                            ]
                          : [
                              AppColors.primaryLight,
                              AppColors.secondaryLight,
                            ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.isActive
                            ? AppColors.primary.withValues(alpha: 0.4)
                            : AppColors.primaryLight.withValues(alpha: 0.25),
                        blurRadius: widget.isActive ? 24 : 12,
                        spreadRadius: widget.isActive ? 2 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppColors.white,
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
