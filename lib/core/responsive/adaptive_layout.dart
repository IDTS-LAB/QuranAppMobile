import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Coarse layout bucket derived from available width.
///
/// New code should prefer [AppBreakpoint] (5 buckets). [AdaptiveSize] is
/// preserved for backward compatibility and maps large/extraLarge onto
/// [AdaptiveSize.expanded].
enum AdaptiveSize { compact, medium, expanded }

/// Helpers for constraint-based (not device-based) adaptive layouts.
abstract final class AdaptiveLayout {
  /// Resolves the [AdaptiveSize] for the given available [width].
  ///
  /// Mapping: compact → [AdaptiveSize.compact]; medium →
  /// [AdaptiveSize.medium]; expanded/large/extraLarge →
  /// [AdaptiveSize.expanded].
  static AdaptiveSize sizeOf(double width) {
    final breakpoint = Breakpoints.breakpointOf(width);
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return AdaptiveSize.compact;
      case AppBreakpoint.medium:
        return AdaptiveSize.medium;
      case AppBreakpoint.expanded:
      case AppBreakpoint.large:
      case AppBreakpoint.extraLarge:
        return AdaptiveSize.expanded;
    }
  }

  /// Resolves the full [AppBreakpoint] for [width].
  static AppBreakpoint breakpointOf(double width) =>
      Breakpoints.breakpointOf(width);

  /// Builds with the [AdaptiveSize] resolved from [LayoutBuilder] constraints.
  static Widget builder({
    required Widget Function(BuildContext context, AdaptiveSize size) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          builder(context, sizeOf(constraints.maxWidth)),
    );
  }

  /// Builds with the full [AppBreakpoint] from [LayoutBuilder] constraints.
  static Widget breakpointBuilder({
    required Widget Function(BuildContext context, AppBreakpoint breakpoint)
    builder,
    BreakpointConfig? config,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => builder(
        context,
        Breakpoints.breakpointOf(constraints.maxWidth, config),
      ),
    );
  }
}
