import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../app/theme/app_spacing.dart';

/// Noble Forest surface container (brand-green background by default).
///
/// Padding renders *inside* the decoration; [margin] outside. Width is
/// unconstrained so surfaces size naturally in flex/grid parents.
///
/// ```dart
/// AppSurface(child: content)
/// ```
class AppSurface extends StatelessWidget {
  /// Creates a surface with theme-derived defaults.
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

  /// Surface content.
  final Widget? child;

  /// Inner padding (inside decoration). Defaults to 16px.
  final EdgeInsetsGeometry? padding;

  /// Outer margin (outside decoration). Defaults to zero.
  final EdgeInsetsGeometry? margin;

  /// Corner radius override.
  final BorderRadius? borderRadius;

  /// Background override.
  final Color? backgroundColor;

  /// Border override.
  final BoxBorder? border;

  /// Shadow override.
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final surface = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.nobleGreen,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
        border: border ?? Border.all(color: AppColors.border),
        boxShadow: shadow ?? AppShadows.none,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );

    if (margin == null) return surface;
    return Padding(padding: margin!, child: surface);
  }
}
