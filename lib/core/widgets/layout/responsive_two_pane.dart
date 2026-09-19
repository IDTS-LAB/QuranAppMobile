import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/foldable/fold_info.dart';
import 'package:quran_app/core/responsive/foldable/foldable_layout.dart';

/// Single-pane below [breakpoint], side-by-side at/above it.
///
/// Never splits when the second pane would be unusable (narrow region,
/// separating hinge with a cramped side). Fold-aware via [FoldInfo].
///
/// ```dart
/// ResponsiveTwoPaneLayout(first: NavigationPanel(), second: ContentPanel())
/// ```
class ResponsiveTwoPaneLayout extends StatelessWidget {
  /// Creates an adaptive one/two-pane layout.
  const ResponsiveTwoPaneLayout({
    super.key,
    required this.first,
    required this.second,
    this.breakpoint = AppBreakpoint.expanded,
    this.splitRatio = 0.4,
    this.minSecondPaneWidth = 320,
    this.separator = const VerticalDivider(width: 1),
  });

  /// Primary pane (list / navigation).
  final Widget first;

  /// Secondary pane (detail / content).
  final Widget second;

  /// Minimum breakpoint for two panes (fold hinge can also trigger it).
  final AppBreakpoint breakpoint;

  /// Fraction of width given to [first] in two-pane mode.
  final double splitRatio;

  /// Minimum usable width for [second]; below this stays single-pane.
  final double minSecondPaneWidth;

  /// Divider between panes.
  final Widget separator;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = FoldInfo.fromContext(context);
        final twoPane = FoldableLayout.shouldUseTwoPanes(
          width: constraints.maxWidth,
          info: info,
          splitRatio: splitRatio,
          minPaneWidth: minSecondPaneWidth,
          minBreakpoint: breakpoint,
        );
        if (!twoPane) return first;
        return Row(
          children: <Widget>[
            Flexible(flex: (splitRatio * 100).round(), child: first),
            separator,
            Flexible(flex: ((1 - splitRatio) * 100).round(), child: second),
          ],
        );
      },
    );
  }
}
