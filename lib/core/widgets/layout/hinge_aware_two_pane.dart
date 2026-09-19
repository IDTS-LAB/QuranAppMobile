import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/foldable/fold_info.dart';
import 'package:quran_app/core/responsive/foldable/foldable_layout.dart';

/// Pane strategy for [HingeAwareTwoPane].
enum PaneStrategy {
  /// Split when hinge regions or width allow it.
  automatic,

  /// Always single pane (e.g. forced phone flow).
  single,

  /// Always two panes when both fit (overrides breakpoint).
  dual,
}

/// Hinge-aware two-pane: single pane on compact screens, two panes when
/// usable regions support it, safe fallback without hinge info.
///
/// ```dart
/// HingeAwareTwoPane(first: FirstPane(), second: SecondPane())
/// ```
class HingeAwareTwoPane extends StatelessWidget {
  /// Creates a hinge-aware two-pane.
  const HingeAwareTwoPane({
    super.key,
    required this.first,
    required this.second,
    this.paneStrategy = PaneStrategy.automatic,
    this.minPaneWidth = 320,
    this.splitRatio = 0.4,
    this.minBreakpoint = AppBreakpoint.expanded,
    this.separator = const VerticalDivider(width: 1),
  });

  /// Primary pane.
  final Widget first;

  /// Secondary pane.
  final Widget second;

  /// Override for pane behavior.
  final PaneStrategy paneStrategy;

  /// Minimum usable width per pane.
  final double minPaneWidth;

  /// Fraction of width for [first].
  final double splitRatio;

  /// Minimum breakpoint for automatic two-pane.
  final AppBreakpoint minBreakpoint;

  /// Divider between panes.
  final Widget separator;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = FoldInfo.fromContext(context);
        final twoPane = switch (paneStrategy) {
          PaneStrategy.single => false,
          PaneStrategy.dual =>
            constraints.maxWidth * splitRatio >= minPaneWidth * 0.6 &&
                constraints.maxWidth * (1 - splitRatio) >= minPaneWidth,
          PaneStrategy.automatic => FoldableLayout.shouldUseTwoPanes(
            width: constraints.maxWidth,
            info: info,
            splitRatio: splitRatio,
            minPaneWidth: minPaneWidth,
            minBreakpoint: minBreakpoint,
          ),
        };
        if (!twoPane) return first;
        // Keep panes out from under a vertical hinge.
        final hingeGap = info.isSeparating && info.hingeAxis == Axis.vertical
            ? SizedBox(width: info.hingeBounds?.width ?? 0)
            : const SizedBox.shrink();
        return Row(
          children: <Widget>[
            Flexible(flex: (splitRatio * 100).round(), child: first),
            separator,
            hingeGap,
            Flexible(flex: ((1 - splitRatio) * 100).round(), child: second),
          ],
        );
      },
    );
  }
}
