import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Coarse layout bucket derived from available width.
enum AdaptiveSize { compact, medium, expanded }

/// Helpers for constraint-based (not device-based) adaptive layouts.
abstract final class AdaptiveLayout {
  /// Resolves the [AdaptiveSize] for the given available [width].
  static AdaptiveSize sizeOf(double width) {
    if (Breakpoints.isCompact(width)) {
      return AdaptiveSize.compact;
    }
    if (Breakpoints.isExpanded(width)) {
      return AdaptiveSize.expanded;
    }
    return AdaptiveSize.medium;
  }

  /// Builds with the [AdaptiveSize] resolved from [LayoutBuilder] constraints.
  static Widget builder({
    required Widget Function(BuildContext context, AdaptiveSize size) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          builder(context, sizeOf(constraints.maxWidth)),
    );
  }
}
