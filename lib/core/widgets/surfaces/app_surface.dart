import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

/// Noble Forest - Premium Quranic UI Surface Container Component
///
/// Reference:
/// - Noble Green background
/// - white/light content
/// - 16px rounded corners
/// - compact but comfortable padding
class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.shadow,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final Widget surface = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.nobleGreen,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
        border: border ?? Border.all(color: AppColors.border),
        boxShadow: shadow ?? AppShadows.none,
      ),
      child: child,
    );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSpacing.md),
        child: surface,
      ),
    );
  }
}