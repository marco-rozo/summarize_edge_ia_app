import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/summary_bottom_nav_widget/summary_bottom_nav_item_widget.dart';

class SummaryBottomNavItem {
  const SummaryBottomNavItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class SummaryBottomNavWidget extends StatefulWidget {
  const SummaryBottomNavWidget({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.items = const [
      SummaryBottomNavItem(icon: Icons.home_rounded, label: 'Home'),
      SummaryBottomNavItem(icon: Icons.mic_rounded, label: 'New Summary'),
      SummaryBottomNavItem(icon: Icons.settings_rounded, label: 'Settings'),
    ],
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<SummaryBottomNavItem> items;

  @override
  State<SummaryBottomNavWidget> createState() => _SummaryBottomNavWidgetState();
}

class _SummaryBottomNavWidgetState extends State<SummaryBottomNavWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant SummaryBottomNavWidget oldWidget) {
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
                children: List.generate(widget.items.length, (index) {
                  final item = widget.items[index];
                  return SummaryBottomNavItemWidget(
                    index: index,
                    icon: item.icon,
                    label: item.label,
                    isSelected: _selectedIndex == index,
                    onTap: _handleTap,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
