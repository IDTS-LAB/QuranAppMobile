import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';

/// Noble Forest - Premium Quranic UI Badge Component
enum AppBadgeVariant { tag, premium, success, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.tag,
  });

  final String label;
  final AppBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (variant) {
      case AppBadgeVariant.tag:
        backgroundColor = AppColors.nobleGreen.withValues(alpha: 0.1);
        textColor = AppColors.nobleGreen;
        break;
      case AppBadgeVariant.premium:
        backgroundColor = AppColors.nobleGold.withValues(alpha: 0.1);
        textColor = AppColors.nobleGold;
        break;
      case AppBadgeVariant.success:
        backgroundColor = AppColors.success.withValues(alpha: 0.1);
        textColor = AppColors.success;
        break;
      case AppBadgeVariant.neutral:
        backgroundColor = AppColors.mutedSurface;
        textColor = AppColors.textSecondary;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}