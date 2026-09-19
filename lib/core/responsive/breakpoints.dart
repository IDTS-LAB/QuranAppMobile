/// Centralized width breakpoints (Material 3 window size classes, adapted).
///
/// | Breakpoint  | Width       | Typical usage                            |
/// | ----------- | ----------- | ---------------------------------------- |
/// | Compact     | < 600dp     | Phones                                   |
/// | Medium      | 600–839dp   | Small tablets, large phones in landscape |
/// | Expanded    | 840–1199dp  | Tablets, foldables, desktop windows      |
/// | Large       | 1200–1599dp | Large tablets and desktop                |
/// | ExtraLarge  | >= 1600dp   | Wide desktop layouts                     |
///
/// Always resolve from available width ([LayoutBuilder] constraints or
/// window width), never from physical device labels. A folded foldable
/// reports a compact window despite being physically large.
enum AppBreakpoint {
  /// Phones (< 600dp).
  compact,

  /// Small tablets / large phones in landscape (600–839dp).
  medium,

  /// Tablets, foldables, desktop-sized windows (840–1199dp).
  expanded,

  /// Large tablets and desktop (1200–1599dp).
  large,

  /// Wide desktop layouts (>= 1600dp).
  extraLarge,
}

/// Centralized breakpoint definitions.
///
/// Do not hardcode widths elsewhere — use [breakpointOf] or the
/// [AppBreakpoint] helpers. Thresholds are configurable via [config].
abstract final class Breakpoints {
  /// Upper bound (exclusive) of [AppBreakpoint.compact].
  static const double compactMaxWidth = 600;

  /// Lower bound (inclusive) of [AppBreakpoint.medium].
  static const double mediumMinWidth = 600;

  /// Upper bound (exclusive) of [AppBreakpoint.medium].
  static const double mediumMaxWidth = 840;

  /// Lower bound (inclusive) of [AppBreakpoint.expanded].
  static const double expandedMinWidth = 840;

  /// Upper bound (exclusive) of [AppBreakpoint.expanded].
  static const double expandedMaxWidth = 1200;

  /// Lower bound (inclusive) of [AppBreakpoint.large].
  static const double largeMinWidth = 1200;

  /// Upper bound (exclusive) of [AppBreakpoint.large].
  static const double largeMaxWidth = 1600;

  /// Lower bound (inclusive) of [AppBreakpoint.extraLarge].
  static const double extraLargeMinWidth = 1600;

  /// Legacy threshold kept for backward compatibility.
  ///
  /// Previously `medium` spanned 600–1024 and `expanded` was >1024.
  /// Prefer the [AppBreakpoint] ranges above.
  @Deprecated('Use AppBreakpoint ranges (expanded starts at 840).')
  static const double legacyExpandedMinWidth = 1024;

  /// Resolves the breakpoint for the given available [width].
  static AppBreakpoint breakpointOf(double width, [BreakpointConfig? config]) {
    final c = config ?? BreakpointConfig.material;
    if (width < c.compactMax) return AppBreakpoint.compact;
    if (width < c.mediumMax) return AppBreakpoint.medium;
    if (width < c.expandedMax) return AppBreakpoint.expanded;
    if (width < c.largeMax) return AppBreakpoint.large;
    return AppBreakpoint.extraLarge;
  }

  /// Legacy: width < 600.
  static bool isCompact(double width) => width < compactMaxWidth;

  /// Legacy medium range (600–1024) preserved for backward compatibility.
  ///
  /// New code should use [breakpointOf] / [AppBreakpoint] instead.
  static bool isMedium(double width) =>
      width >= compactMaxWidth && width <= legacyExpandedMinWidth;

  /// Legacy: width > 1024 preserved for backward compatibility.
  ///
  /// New code should use [breakpointOf] / [AppBreakpoint] instead.
  static bool isExpanded(double width) => width > legacyExpandedMinWidth;

  /// Whether [width] reaches at least [breakpoint].
  static bool isAtLeast(double width, AppBreakpoint breakpoint) {
    return breakpointOf(width).index >= breakpoint.index;
  }
}

/// Custom breakpoint configuration.
///
/// Defaults to [BreakpointConfig.material]; override for app-specific needs.
class BreakpointConfig {
  const BreakpointConfig({
    required this.compactMax,
    required this.mediumMax,
    required this.expandedMax,
    required this.largeMax,
  });

  /// Material 3 window size classes used by default.
  static const BreakpointConfig material = BreakpointConfig(
    compactMax: 600,
    mediumMax: 840,
    expandedMax: 1200,
    largeMax: 1600,
  );

  /// Upper bound (exclusive) of compact.
  final double compactMax;

  /// Upper bound (exclusive) of medium.
  final double mediumMax;

  /// Upper bound (exclusive) of expanded.
  final double expandedMax;

  /// Upper bound (exclusive) of large.
  final double largeMax;
}

/// Type-safe helpers on [AppBreakpoint].
extension AppBreakpointX on AppBreakpoint {
  /// True for [AppBreakpoint.compact].
  bool get isCompact => this == AppBreakpoint.compact;

  /// True for [AppBreakpoint.medium].
  bool get isMedium => this == AppBreakpoint.medium;

  /// True for [AppBreakpoint.expact] or larger.
  bool get isAtLeastExpanded => index >= AppBreakpoint.expanded.index;

  /// True for [AppBreakpoint.large] or larger.
  bool get isAtLeastLarge => index >= AppBreakpoint.large.index;

  /// Compact shorthand used for single-column layouts.
  bool get isSinglePane => this == AppBreakpoint.compact;
}
