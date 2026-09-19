import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Noble Forest - Premium Quranic UI Badge Component
///
/// Displays a badge with a label and a variant-based background color.
/// The [textStyle] parameter allows customization of the text appearance.
/// If [textStyle] is null, the default style (based on the variant) is used.
enum AppBadgeVariant { tag, premium, success, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.tag,
    this.textStyle,
  });

  final String label;
  final AppBadgeVariant variant;
  final TextStyle? textStyle;

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

    final TextStyle effectiveTextStyle =
        textStyle ??
        AppTypography.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
        );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label.toUpperCase(),
        style: effectiveTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
