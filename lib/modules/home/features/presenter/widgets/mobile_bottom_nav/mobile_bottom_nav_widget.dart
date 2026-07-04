import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/modules/home/features/presenter/widgets/mobile_bottom_nav/mobile_bottom_nav_item_widget.dart';

class MobileBottomNavWidget extends StatefulWidget {
  const MobileBottomNavWidget({super.key, this.currentIndex = 0, this.onTap});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  State<MobileBottomNavWidget> createState() => _MobileBottomNavWidgetState();
}

class _MobileBottomNavWidgetState extends State<MobileBottomNavWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant MobileBottomNavWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _selectedIndex = widget.currentIndex;
    }
  }

  void _handleTap(int index) {
    setState(() => _selectedIndex = index);
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow.withValues(alpha: 0.75),
            border: const Border(
              top: BorderSide(color: AppColors.surfaceBorder, width: 1),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MobileBottomNavItemWidget(
                    index: 0,
                    icon: Icons.home_rounded,
                    label: 'Home',
                    isSelected: _selectedIndex == 0,
                    onTap: _handleTap,
                  ),
                  MobileBottomNavItemWidget(
                    index: 1,
                    icon: Icons.mic_rounded,
                    label: 'New Summary',
                    isSelected: _selectedIndex == 1,
                    onTap: _handleTap,
                  ),
                  MobileBottomNavItemWidget(
                    index: 2,
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    isSelected: _selectedIndex == 2,
                    onTap: _handleTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
