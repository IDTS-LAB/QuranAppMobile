import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_radius.dart';
import 'package:quran_app/app/theme/app_shadows.dart';
import 'package:quran_app/app/theme/app_spacing.dart';

/// Noble Forest - Premium Quranic UI Primary Card Component
///
/// Reference:
/// - white surface
/// - subtle border
/// - very subtle shadow
/// - approximately 32px radius
/// - generous padding
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.shadow,
    this.onTap,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget card = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.lg),
        border: border ?? Border.all(color: AppColors.border),
        boxShadow: shadow ?? AppShadows.sm,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: padding ?? EdgeInsets.all(AppSpacing.lg),
          child: card,
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSpacing.lg),
        child: card,
      ),
    );
  }
}
