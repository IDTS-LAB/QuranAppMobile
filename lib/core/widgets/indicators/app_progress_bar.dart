import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';

/// Noble Forest - Premium Quranic UI Progress Bar Component
///
/// Reference:
/// - thin horizontal track
/// - light neutral track
/// - rounded ends
/// - green or gold progress
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.height = 4,
    this.semanticsLabel,
  });

  final double value; // 0.0 to 1.0
  final Color? backgroundColor;
  final Color? valueColor;
  final double height;

  /// Screen-reader label for the progress value.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      value: '${(value.clamp(0.0, 1.0) * 100).round()}%',
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? AppColors.mutedSurface,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? AppColors.nobleGreen,
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    );
  }
}
