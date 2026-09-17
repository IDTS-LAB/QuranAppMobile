import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Noble Forest - Premium Quranic UI Section Label Component
///
/// Characteristics:
/// - Noble Gold
/// - uppercase
/// - SemiBold
/// - small size
/// - increased letter spacing
/// - compact line height
class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppTypography.labelMedium.copyWith(
        color: AppColors.nobleGold,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        height: 1.2,
      ),
    );
  }
}
