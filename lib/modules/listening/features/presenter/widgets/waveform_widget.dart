import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

/// Animated waveform visualizer composed of 5 vertical bars.
///
/// When [isActive] is `true`, each bar plays a staggered scale animation
/// that mimics an audio waveform. When inactive, bars are shown at a
/// static minimum height.
class WaveformWidget extends StatefulWidget {
  const WaveformWidget({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget>
    with TickerProviderStateMixin {
  static const List<double> _delays = [0.0, 0.2, 0.4, 0.1, 0.3];
  static const List<double> _maxHeights = [64, 96, 128, 80, 48];

  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _buildAnimations();
    if (widget.isActive) _startAll();
  }

  void _buildAnimations() {
    for (int i = 0; i < 5; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      );
      final animation = Tween<double>(begin: 0.15, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
      _controllers.add(controller);
      _animations.add(animation);
    }
  }

  void _startAll() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(
        Duration(milliseconds: (_delays[i] * 1000).round()),
        () {
          if (mounted && widget.isActive) {
            _controllers[i].repeat(reverse: true);
          }
        },
      );
    }
  }

  void _stopAll() {
    for (final c in _controllers) {
      c.stop();
      c.animateTo(0.15, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  void didUpdateWidget(covariant WaveformWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _startAll();
    } else if (!widget.isActive && oldWidget.isActive) {
      _stopAll();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: widget.isActive ? 1.0 : 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(5, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: AnimatedBuilder(
              animation: _animations[i],
              builder: (_, _) {
                return Container(
                  width: 6,
                  height: _maxHeights[i] * _animations[i].value,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: 0.6 + 0.4 * _animations[i].value,
                    ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
