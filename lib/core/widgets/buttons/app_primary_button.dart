import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Noble Forest - Premium Quranic UI Primary Button Component
///
/// Reference:
/// - Noble Green background
/// - white text
/// - 16px radius
/// - approximately 52–56px height
/// - SemiBold label
/// - comfortable horizontal padding
///
/// The [textStyle] parameter allows customization of the text appearance.
/// If [textStyle] is null, the default style (based on the enabled state) is used.
///
/// Long labels ellipsize instead of overflowing narrow windows; the minimum
/// 48dp touch target is always preserved for accessibility.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
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
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.surface),
              ),
            )
          else
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    textStyle ??
                    AppTypography.titleMedium.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w600,
                    ),
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
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.nobleGreen
              : AppColors.disabled,
          foregroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
          minimumSize: const Size(48, 48),
        ),
        child: content,
      ),
    );
  }
}
