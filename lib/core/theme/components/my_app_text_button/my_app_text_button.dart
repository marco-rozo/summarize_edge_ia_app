import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Reusable text button for the "Edge Neural" design system.
///
/// Suitable for secondary/skip actions, inline links, and text-only buttons.
class MyAppTextButton extends StatelessWidget {
  const MyAppTextButton({
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

  /// The button label text.
  final String text;

  /// Callback when tapped. If null, button is disabled.
  final VoidCallback? onPressed;

  /// Text and icon foreground color. Defaults to [AppColors.onSurfaceVariant].
  final Color textColor;

  /// Splash / overlay color when pressed or hovered. Defaults to [AppColors.primary].
  final Color overlayColor;

  /// Internal padding. Defaults to 12px horizontal and vertical.
  final EdgeInsetsGeometry padding;

  /// Custom text style. If null, defaults to [AppTextStyle.labelMd] with [textColor].
  final TextStyle? textStyle;

  /// Optional icon placed before the text.
  final IconData? leftIcon;

  /// Optional icon placed after the text.
  final IconData? rightIcon;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle = (textStyle ?? AppTextStyle.labelMd).copyWith(
      color: onPressed == null ? AppColors.disabled : textColor,
    );

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: onPressed == null ? AppColors.disabled : textColor,
        padding: padding,
        overlayColor: overlayColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leftIcon != null) ...[
            Icon(leftIcon, size: 16, color: effectiveStyle.color),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: effectiveStyle,
          ),
          if (rightIcon != null) ...[
            const SizedBox(width: 6),
            Icon(rightIcon, size: 16, color: effectiveStyle.color),
          ],
        ],
      ),
    );
  }
}
