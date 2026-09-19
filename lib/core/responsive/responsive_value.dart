import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'responsive_context.dart';

/// Resolves a value per breakpoint with fallback to the nearest defined one.
///
/// Supports numbers, [EdgeInsets], [TextStyle], enums, colors, widgets —
/// any type [T].
///
/// ```dart
/// final padding = ResponsiveValue<EdgeInsets>(
///   compact: const EdgeInsets.all(16),
///   medium: const EdgeInsets.all(24),
///   expanded: const EdgeInsets.all(32),
/// ).resolve(context);
/// ```
///
/// Only [compact] is required; unspecified breakpoints fall back toward
/// compact (e.g. `large` falls back to `expanded` → `medium` → `compact`).
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  });

  /// Value for compact windows. Required fallback for all breakpoints.
  final T compact;

  /// Value for medium windows. Falls back to [compact].
  final T? medium;

  /// Value for expanded windows. Falls back to [medium] → [compact].
  final T? expanded;

  /// Value for large windows. Falls back to [expanded] → … → [compact].
  final T? large;

  /// Value for extra-large windows. Falls back to [large] → … → [compact].
  final T? extraLarge;

  /// Resolves for an explicit [breakpoint].
  T resolveFor(AppBreakpoint breakpoint) {
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return compact;
      case AppBreakpoint.medium:
        return medium ?? compact;
      case AppBreakpoint.expanded:
        return expanded ?? medium ?? compact;
      case AppBreakpoint.large:
        return large ?? expanded ?? medium ?? compact;
      case AppBreakpoint.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
    }
  }

  /// Resolves for the breakpoint of [context]'s available width.
  T resolve(BuildContext context) => resolveFor(context.appBreakpoint);

  /// Resolves for an explicit available [width].
  T resolveWidth(double width) => resolveFor(Breakpoints.breakpointOf(width));
}

/// Convenience helpers for common responsive value lookups.
abstract final class AppResponsive {
  /// Returns the value matching the current breakpoint.
  ///
  /// ```dart
  /// AppResponsive.value(context, compact: 16, medium: 24, expanded: 32);
  /// ```
  static T value<T>(
    BuildContext context, {
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
  }) {
    return ResponsiveValue<T>(
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
      extraLarge: extraLarge,
    ).resolve(context);
  }

  /// Width-based lookup without a [BuildContext] (e.g. inside
  /// `LayoutBuilder`).
  static T valueForWidth<T>(
    double width, {
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
  }) {
    return ResponsiveValue<T>(
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
      extraLarge: extraLarge,
    ).resolveWidth(width);
  }

  /// Linearly interpolates [min]→[max] across [minWidth]→[maxWidth].
  ///
  /// Clamped to `[min, max]`. Prefer [value] with discrete steps for
  /// layout-critical decisions; use this for fluid spacing flourishes.
  static double interpolate(
    BuildContext context, {
    required double min,
    required double max,
    double minWidth = 360,
    double maxWidth = 1200,
  }) {
    final width = context.screenWidth.clamp(minWidth, maxWidth);
    final t = (width - minWidth) / (maxWidth - minWidth);
    return min + (max - min) * t;
  }
}
