import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class SummaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SummaryAppBar({
    super.key,
    this.title = '',
    this.titleWidget,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onPop,
    this.centerTitle = false,
    this.showBottomBorder = true,
    this.bottom,
    this.elevation = 0,
    this.backgroundColor,
  });

  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onPop;
  final bool centerTitle;
  final bool showBottomBorder;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? backgroundColor;

  @override
  Size get preferredSize {
    final bottomHeight =
        bottom?.preferredSize.height ?? (showBottomBorder ? 1.0 : 0.0);
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBottom = bottom ??
        (showBottomBorder
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(color: AppColors.surfaceBorder, height: 1),
              )
            : null);

    final bool canPop = Navigator.of(context).canPop();
    final bool shouldShowBack =
        showBackButton && (leading == null) && (onPop != null || canPop);

    final Widget? effectiveLeading = leading ??
        (shouldShowBack
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.onSurface,
                ),
                tooltip: 'Voltar',
                onPressed: onPop ?? () => Navigator.of(context).maybePop(),
              )
            : null);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: effectiveLeading,
      title: titleWidget ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (effectiveLeading == null) const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyle.headlineMd.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      backgroundColor:
          backgroundColor ?? AppColors.surface.withValues(alpha: 0.7),
      elevation: elevation,
      centerTitle: centerTitle,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(color: AppColors.transparent),
        ),
      ),
      bottom: effectiveBottom,
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: 12),
            ]
          : null,
    );
  }
}
