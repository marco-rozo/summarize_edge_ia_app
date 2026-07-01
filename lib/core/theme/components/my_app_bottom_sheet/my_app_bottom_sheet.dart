import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

/// Edge Neural glassmorphism bottom sheet helper.
///
/// The blurred variant uses a **20px backdrop blur** + semi-transparent
/// dark tint `rgba(11,11,11,0.7)` over a `#201F1F` container with a
/// 1px top border — matching the design's "Glassmorphism" layer spec.
mixin MyAppBottomSheet {
  Future<void> showMyAppBlurredBottomSheet(
    BuildContext context, {
    bool showDragHandle = false,
    double blurIntensity = 20,
    bool isScrollControlled = false,
    required Widget child,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.black.withValues(alpha: 0.5),
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                decoration: const BoxDecoration(
                  // Dark glass tint
                  color: AppColors.glassOverlay,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(color: AppColors.surfaceBorder, width: 1),
                    left: BorderSide(color: AppColors.surfaceBorder, width: 1),
                    right: BorderSide(color: AppColors.surfaceBorder, width: 1),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showDragHandle)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: Container(
                            width: 32,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.dragHandle,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future<dynamic> showMyAppBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool showDragHandle = true,
    bool enableDrag = true,
    double elevation = 0,
    Color? barrierColor,
    double initialChildSize = 0.5,
  }) =>
      showModalBottomSheet(
        isDismissible: isDismissible,
        showDragHandle: showDragHandle,
        enableDrag: enableDrag,
        elevation: elevation,
        useSafeArea: true,
        barrierColor: barrierColor ?? AppColors.black.withValues(alpha: 0.5),
        isScrollControlled: isScrollControlled,
        // Surface container with 1px border
        backgroundColor: AppColors.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          side: BorderSide(color: AppColors.surfaceBorder, width: 1),
        ),
        context: context,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          snap: true,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: child,
              ),
            );
          },
        ),
      );
}
