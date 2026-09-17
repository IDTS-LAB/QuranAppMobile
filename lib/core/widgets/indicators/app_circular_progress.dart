import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Noble Forest - Premium Quranic UI Circular Progress Component
class AppCircularProgress extends StatelessWidget {
  const AppCircularProgress({
    super.key,
    this.value,
    this.strokeWidth = 3,
    this.backgroundColor,
    this.valueColor,
  });

  final double? value; // null for indeterminate
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor ?? AppColors.mutedSurface,
        valueColor: valueColor != null
            ? AlwaysStoppedAnimation<Color>(valueColor!)
            : AlwaysStoppedAnimation<Color>(AppColors.nobleGreen),
      ),
    );
  }
}
