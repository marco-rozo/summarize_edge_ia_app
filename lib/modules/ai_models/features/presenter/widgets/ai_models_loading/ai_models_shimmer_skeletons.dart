import 'package:flutter/material.dart';
import 'package:summary_app/core/theme/assets/app_colors.dart';

class ShimmerSkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerSkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerHeaderSkeleton extends StatelessWidget {
  const ShimmerHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerSkeletonBox(width: 280, height: 28, borderRadius: 6),
        SizedBox(height: 12),
        ShimmerSkeletonBox(width: 450, height: 16, borderRadius: 4),
      ],
    );
  }
}

class ShimmerRuntimeSkeleton extends StatelessWidget {
  const ShimmerRuntimeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerSkeletonBox(width: 140, height: 16, borderRadius: 4),
        SizedBox(height: 16),
        ShimmerSkeletonBox(
          width: double.infinity,
          height: 240,
          borderRadius: 16,
        ),
        SizedBox(height: 16),
        ShimmerSkeletonBox(
          width: double.infinity,
          height: 80,
          borderRadius: 12,
        ),
      ],
    );
  }
}

class ShimmerLibrarySkeleton extends StatelessWidget {
  const ShimmerLibrarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerSkeletonBox(width: 180, height: 16, borderRadius: 4),
            ShimmerSkeletonBox(width: 60, height: 22, borderRadius: 6),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return const ShimmerSkeletonBox(
              width: double.infinity,
              height: 140,
              borderRadius: 16,
            );
          },
        ),
      ],
    );
  }
}
