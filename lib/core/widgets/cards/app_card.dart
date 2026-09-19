import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_radius.dart';
import 'package:quran_app/app/theme/app_shadows.dart';
import 'package:quran_app/app/theme/app_spacing.dart';

/// Card style variants with theme-derived defaults.
enum AppCardVariant {
  /// White surface, subtle border, subtle shadow (default).
  elevated,

  /// Muted surface, no border emphasis.
  filled,

  /// Transparent with border only.
  outlined,
}

/// Noble Forest primary card with sensible zero-config defaults.
///
/// ```dart
/// AppCard(child: Text('Hello'))
/// AppCard(variant: AppCardVariant.filled, onTap: ..., child: ...)
/// AppCard(padding: EdgeInsets.all(24), child: ...)
/// ```
///
/// Padding renders *inside* the decoration; [margin] outside. Width is
/// unconstrained by default so cards size naturally in grids (pass an
/// explicit width via a parent constraint when needed).
class AppCard extends StatelessWidget {
  /// Creates a card with theme-derived defaults.
  const AppCard({
    super.key,
    this.child,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.shadow,
    this.onTap,
    this.clipBehavior,
  });

  /// Card content.
  final Widget? child;

  /// Style variant (defaults handle ~90% of cases).
  final AppCardVariant variant;

  /// Inner padding (inside decoration). Defaults to 24px.
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

  /// Optional tap handler (adds ink ripple inside the card shape).
  final VoidCallback? onTap;

  /// Clip behavior for content/decoration.
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppRadius.lg);
    final decoration = BoxDecoration(
      color: backgroundColor ?? _backgroundFor(variant),
      borderRadius: radius,
      border: border ?? _borderFor(variant),
      boxShadow: shadow ?? _shadowFor(variant),
    );

    Widget card = Container(
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      decoration: decoration,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, borderRadius: radius, child: card),
      );
    }

    if (margin == null) return card;
    return Padding(padding: margin!, child: card);
  }

  Color _backgroundFor(AppCardVariant v) {
    switch (v) {
      case AppCardVariant.elevated:
        return AppColors.surface;
      case AppCardVariant.filled:
        return AppColors.mutedSurface;
      case AppCardVariant.outlined:
        return Colors.transparent;
    }
  }

  BoxBorder? _borderFor(AppCardVariant v) {
    switch (v) {
      case AppCardVariant.elevated:
      case AppCardVariant.outlined:
        return Border.all(color: AppColors.border);
      case AppCardVariant.filled:
        return null;
    }
  }

  List<BoxShadow>? _shadowFor(AppCardVariant v) {
    switch (v) {
      case AppCardVariant.elevated:
        return AppShadows.sm;
      case AppCardVariant.filled:
      case AppCardVariant.outlined:
        return AppShadows.none;
    }
  }
}
