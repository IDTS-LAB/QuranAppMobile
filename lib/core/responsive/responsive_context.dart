import 'package:flutter/material.dart';

import 'breakpoints.dart';
import 'foldable/fold_info.dart';
import 'responsive_value.dart';

/// Convenient constraint/window queries on [BuildContext].
///
/// Window-size getters use [MediaQuery] (fine at page/scaffold level).
/// Deeply nested reusable components should prefer `LayoutBuilder`
/// constraints via [ResponsiveBuilder] / [ResponsiveLayout] so they react
/// to available space rather than the full window.
extension ResponsiveContext on BuildContext {
  /// Full window width (includes areas outside this widget's constraints).
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Full window height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Breakpoint for the full window width.
  AppBreakpoint get appBreakpoint => Breakpoints.breakpointOf(screenWidth);

  /// Shorthand for `appBreakpoint == AppBreakpoint.compact`.
  bool get isCompact => appBreakpoint == AppBreakpoint.compact;

  /// Shorthand for `appBreakpoint == AppBreakpoint.medium`.
  bool get isMedium => appBreakpoint == AppBreakpoint.medium;

  /// Shorthand for `appBreakpoint == AppBreakpoint.expanded`.
  bool get isExpanded => appBreakpoint == AppBreakpoint.expanded;

  /// Shorthand for `appBreakpoint == AppBreakpoint.large`.
  bool get isLarge => appBreakpoint == AppBreakpoint.large;

  /// Shorthand for `appBreakpoint == AppBreakpoint.extraLarge`.
  bool get isExtraLarge => appBreakpoint == AppBreakpoint.extraLarge;

  /// True when width reaches at least expanded (>= 840dp).
  bool get isAtLeastExpanded => appBreakpoint.isAtLeastExpanded;

  /// True when width reaches at least large (>= 1200dp).
  bool get isAtLeastLarge => appBreakpoint.isAtLeastLarge;

  /// Portrait when height >= width.
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  /// Landscape when width > height.
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Compact window: single-column, bottom navigation.
  bool get isSinglePane => appBreakpoint.isSinglePane;

  /// Standard horizontal page padding for the current breakpoint.
  ///
  /// Compact 16 / Medium 24 / Expanded 32 / Large 40 / ExtraLarge 48.
  EdgeInsets get responsivePadding => ResponsiveValue<EdgeInsets>(
    compact: const EdgeInsets.symmetric(horizontal: 16),
    medium: const EdgeInsets.symmetric(horizontal: 24),
    expanded: const EdgeInsets.symmetric(horizontal: 32),
    large: const EdgeInsets.symmetric(horizontal: 40),
    extraLarge: const EdgeInsets.symmetric(horizontal: 48),
  ).resolve(this);

  /// Current foldable/window configuration snapshot.
  FoldInfo get foldInfo => FoldInfo.fromContext(this);
}
