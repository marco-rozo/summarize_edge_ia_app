import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button_type_enum.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

/// Edge Neural button.
///
/// Variants (use named constructors):
///   `MyAppButton.primary`  — solid Purple LED with glow on hover.
///   `MyAppButton.secondary` / `.ghost` — transparent + purple border.
///   `MyAppButton.negative` — destructive / error action.
class MyAppButton extends StatefulWidget {
  final MyAppButtonTypeEnum buttonType;
  final Widget? leftWidget;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final bool isLoading;

  const MyAppButton.primary({
    super.key,
    this.leftWidget,
    this.leftIcon,
    this.rightIcon,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.isLoading = false,
  }) : buttonType = MyAppButtonTypeEnum.primary;

  const MyAppButton.secondary({
    super.key,
    this.leftWidget,
    this.leftIcon,
    this.rightIcon,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.isLoading = false,
  }) : buttonType = MyAppButtonTypeEnum.secondary;

  const MyAppButton.negative({
    super.key,
    this.leftWidget,
    this.leftIcon,
    this.rightIcon,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.isLoading = false,
  }) : buttonType = MyAppButtonTypeEnum.negative;

  @override
  State<MyAppButton> createState() => _MyAppButtonState();
}

class _MyAppButtonState extends State<MyAppButton> {
  bool _hovered = false;

  bool get _isDisabled => widget.onPressed == null;

  /// LED glow box-shadow for primary buttons on hover.
  List<BoxShadow> get _boxShadow {
    if (_isDisabled || !_hovered) return const [];
    if (widget.buttonType == MyAppButtonTypeEnum.primary) {
      return [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.30),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];
    }
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        _isDisabled ? widget.buttonType.disabledColor : widget.buttonType.backgroundColor;
    final Color borderColor =
        _isDisabled ? widget.buttonType.disabledColor : widget.buttonType.borderColor;

    // Ghost hover: increase border opacity slightly
    final Color resolvedBorder = (!_isDisabled &&
            _hovered &&
            widget.buttonType == MyAppButtonTypeEnum.secondary)
        ? AppColors.primary.withValues(alpha: 0.65)
        : borderColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 48,
        width: widget.width,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: resolvedBorder, width: 1),
          borderRadius: BorderRadius.circular(4), // 0.25rem — standard buttons
          boxShadow: _boxShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: _isDisabled ? AppColors.transparent : widget.buttonType.splashColor.withValues(alpha: 0.15),
            highlightColor: _isDisabled ? AppColors.transparent : widget.buttonType.splashColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
            onTap: widget.isLoading ? null : widget.onPressed,
            child: widget.isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.buttonType.progressIndicatorColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.leftWidget != null) ...[
                        SizedBox(height: 20, width: 20, child: widget.leftWidget!),
                        const SizedBox(width: 8),
                      ],
                      if (widget.leftIcon != null) ...[
                        Icon(
                          widget.leftIcon!,
                          color: _isDisabled
                              ? AppTextStyle.disabledButtonText.color
                              : widget.buttonType.textStyle.color,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: _isDisabled
                            ? AppTextStyle.disabledButtonText
                            : widget.buttonType.textStyle,
                      ),
                      if (widget.rightIcon != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          widget.rightIcon!,
                          color: _isDisabled
                              ? AppTextStyle.disabledButtonText.color
                              : widget.buttonType.textStyle.color,
                          size: 18,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
