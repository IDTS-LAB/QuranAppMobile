import 'package:flutter/widgets.dart';

import 'breakpoints.dart';
import 'responsive_value.dart';

/// Constraint-based builder: rebuilds with the breakpoint resolved from
/// the parent's available width (not the full window).
///
/// Prefer this inside reusable components over `MediaQuery.size.width`
/// so cards/grids adapt to their actual space (split views, side panels,
/// foldable regions).
///
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, breakpoint) {
///     if (breakpoint.isCompact) return const SingleColumn();
///     return const TwoColumn();
///   },
/// );
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a constraint-based responsive builder.
  const ResponsiveBuilder({super.key, required this.builder, this.config});

  /// Builds with the resolved [AppBreakpoint].
  final Widget Function(BuildContext context, AppBreakpoint breakpoint) builder;

  /// Optional custom thresholds.
  final BreakpointConfig? config;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoints.breakpointOf(
          constraints.maxWidth,
          config,
        );
        return builder(context, breakpoint);
      },
    );
  }
}

/// Value-based variant: resolves a [ResponsiveValue] from constraints.
class ResponsiveValueBuilder<T> extends StatelessWidget {
  /// Creates a value builder from layout constraints.
  const ResponsiveValueBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.config,
  });

  /// Value table to resolve per breakpoint.
  final ResponsiveValue<T> value;

  /// Builds with the resolved value.
  final Widget Function(BuildContext context, T value) builder;

  /// Optional custom thresholds.
  final BreakpointConfig? config;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoints.breakpointOf(
          constraints.maxWidth,
          config,
        );
        return builder(context, value.resolveFor(breakpoint));
      },
    );
  }
}
