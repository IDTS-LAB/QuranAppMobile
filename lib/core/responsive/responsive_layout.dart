import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Constraint-based layout helpers (no `MediaQuery` subscriptions).
///
/// Use at page level via [builder] or query helpers inside `LayoutBuilder`
/// callbacks. Granular `LayoutBuilder` placement avoids rebuilding the
/// whole page for minor constraint changes.
abstract final class ResponsiveLayout {
  /// Builds with the breakpoint resolved from parent constraints.
  static Widget builder({
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

  /// Number of columns for [width] given [minItemWidth] and [maxColumns].
  ///
  /// Pure (testable): `max(1, min(maxColumns, width ~/ minItemWidth))`
  /// adjusted for [spacing].
  static int columnsForWidth(
    double width, {
    double minItemWidth = 160,
    int maxColumns = 4,
    double spacing = 16,
    double padding = 0,
  }) {
    final available = (width - padding * 2 + spacing).clamp(0, double.infinity);
    final raw = (available / (minItemWidth + spacing)).floor();
    return raw.clamp(1, maxColumns);
  }

  /// Whether a two-pane layout is viable at [width].
  ///
  /// Pure (testable). Requires at least [minSecondPaneWidth] for the
  /// secondary pane after the [splitRatio] split.
  static bool shouldUseTwoPane(
    double width, {
    AppBreakpoint? breakpoint,
    double splitRatio = 0.4,
    double minSecondPaneWidth = 320,
    AppBreakpoint minBreakpoint = AppBreakpoint.expanded,
  }) {
    final bp = breakpoint ?? Breakpoints.breakpointOf(width);
    if (bp.index < minBreakpoint.index) return false;
    return width * (1 - splitRatio) >= minSecondPaneWidth;
  }

  /// Standard max content width for a breakpoint (prevents excessive
  /// line lengths on wide screens).
  static double maxContentWidth(AppBreakpoint breakpoint) {
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return 560;
      case AppBreakpoint.medium:
        return 720;
      case AppBreakpoint.expanded:
        return 1024;
      case AppBreakpoint.large:
        return 1200;
      case AppBreakpoint.extraLarge:
        return 1400;
    }
  }
}
