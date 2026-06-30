import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';
import 'package:summary_app/core/theme/components/my_app_button/my_app_button_type_enum.dart';
import 'package:summary_app/core/theme/styles/text_styles.dart';

class MyAppButton extends StatelessWidget {
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

  bool get _isDisabled => onPressed == null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width,
      decoration: BoxDecoration(
        color: _isDisabled
            ? buttonType.disabledColor
            : buttonType.backgroundColor,
        border: Border.all(
          color: _isDisabled
              ? buttonType.disabledColor
              : buttonType.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor:
              _isDisabled ? AppColors.transparent : buttonType.splashColor,
          highlightColor:
              _isDisabled ? AppColors.transparent : buttonType.splashColor,
          borderRadius: BorderRadius.circular(8),
          onTap: isLoading ? null : onPressed,
          child: isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 1.2),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leftWidget != null) ...[
                      SizedBox(height: 24, width: 24, child: leftWidget!),
                      const SizedBox(width: 8.0),
                    ],
                    if (leftIcon != null) ...[
                      Icon(
                        leftIcon!,
                        color: _isDisabled
                            ? AppTextStyle.disabledButtonText.color
                            : buttonType.textStyle.color,
                        size: 20,
                      ),
                      const SizedBox(width: 8.0),
                    ],
                    Text(
                      text,
                      style: _isDisabled
                          ? AppTextStyle.disabledButtonText
                          : buttonType.textStyle,
                    ),
                    if (rightIcon != null) ...[
                      const SizedBox(width: 8.0),
                      Icon(
                        rightIcon!,
                        color: _isDisabled
                            ? AppTextStyle.disabledButtonText.color
                            : buttonType.textStyle.color,
                        size: 20,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
