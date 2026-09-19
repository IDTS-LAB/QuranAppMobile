import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Noble Forest - Premium Quranic UI Secondary Button Component
///
/// Reference:
/// - light/white background
/// - Noble Green text
/// - subtle border
/// - 16px radius
/// - same visual height as primary
///
/// The [textStyle] parameter allows customization of the text appearance.
/// If [textStyle] is null, the default style (based on the enabled state) is used.
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
    this.width,
    this.height,
    this.enabled = true,
    this.loading = false,
    this.textStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool fullWidth;
  final double? width;
  final double? height;
  final bool enabled;
  final bool loading;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && !loading && onPressed != null;

    final Widget content = SizedBox(
      width: width,
      height: height ?? 54,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            const SizedBox(width: AppSpacing.sm),
          ],
          if (loading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.nobleGreen),
              ),
            )
          else
            Text(
              label,
              style:
                  textStyle ??
                  AppTypography.titleMedium.copyWith(
                    color: AppColors.nobleGreen,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          if (trailingIcon != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailingIcon!,
          ],
        ],
      ),
    );

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: isEnabled
              ? AppColors.nobleGreen
              : AppColors.disabled,
          backgroundColor: isEnabled
              ? AppColors.surface
              : AppColors.disabled.withValues(alpha: 0.1),
          side: BorderSide(
            color: isEnabled ? AppColors.nobleGreen : AppColors.disabled,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: content,
      ),
    );
  }
}
