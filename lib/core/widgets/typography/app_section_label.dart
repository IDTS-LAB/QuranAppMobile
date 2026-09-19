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
///
/// Long labels ellipsize on narrow windows; exposed as a header to
/// screen readers.
class AppSectionLabel extends StatelessWidget {
  /// Creates a section label.
  const AppSectionLabel(this.label, {super.key});

  /// Label text (uppercased automatically).
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelMedium.copyWith(
          color: AppColors.nobleGold,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          height: 1.2,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
