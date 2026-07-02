import 'package:flutter/material.dart';

class OnboardingStepData {
  const OnboardingStepData({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
}
