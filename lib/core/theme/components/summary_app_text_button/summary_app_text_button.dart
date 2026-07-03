import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class SummaryAppTextButton extends StatelessWidget {
  const SummaryAppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor = AppColors.onSurfaceVariant,
    this.overlayColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.textStyle,
    this.leftIcon,
    this.rightIcon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color overlayColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final IconData? leftIcon;
  final IconData? rightIcon;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle = (textStyle ?? AppTextStyle.labelMd)
        .copyWith(color: onPressed == null ? AppColors.disabled : textColor);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: onPressed == null ? AppColors.disabled : textColor,
        padding: padding,
        overlayColor: overlayColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leftIcon != null) ...[
            Icon(leftIcon, size: 16, color: effectiveStyle.color),
            const SizedBox(width: 6),
          ],
          Text(text, style: effectiveStyle),
          if (rightIcon != null) ...[
            const SizedBox(width: 6),
            Icon(rightIcon, size: 16, color: effectiveStyle.color),
          ],
        ],
      ),
    );
  }
}
