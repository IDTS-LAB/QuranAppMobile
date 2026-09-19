import 'package:flutter/widgets.dart';

import '../breakpoints.dart';
import 'fold_info.dart';
import 'hinge_utils.dart';

/// Pure pane/hinge layout decisions (unit-testable, no widgets).
///
/// Centralizes rules so `ResponsiveTwoPaneLayout`, `HingeAwareTwoPane`,
/// and `AdaptiveScaffold` agree on when to split.
abstract final class FoldableLayout {
  /// Whether to render two panes for [width] + [info].
  ///
  /// - Separating hinge with two regions each >= [minPaneWidth] → split.
  /// - Otherwise fall back to width-based [ResponsiveLayout]-style rule:
  ///   at least [minBreakpoint] with enough room for both panes.
  static bool shouldUseTwoPanes({
    required double width,
    required FoldInfo info,
    double splitRatio = 0.4,
    double minPaneWidth = 320,
    AppBreakpoint minBreakpoint = AppBreakpoint.expanded,
  }) {
    if (info.isSeparating && info.availableRegions.length >= 2) {
      final regions = List.of(info.availableRegions)
        ..sort((a, b) => b.width.compareTo(a.width));
      if (regions.length >= 2 &&
          regions[0].width >= minPaneWidth &&
          regions[1].width >= minPaneWidth) {
        return true;
      }
      // Separating hinge but a region is too narrow: fall through to
      // single-pane rather than rendering an unusable second pane.
      return false;
    }
    final breakpoint = Breakpoints.breakpointOf(width);
    if (breakpoint.index < minBreakpoint.index) return false;
    return width * (1 - splitRatio) >= minPaneWidth &&
        width * splitRatio >= minPaneWidth * 0.6;
  }

  /// Whether the half-open tabletop stacking applies.
  ///
  /// Conservative: only when posture explicitly reports [FoldPosture.halfOpened]
  /// with a horizontal hinge. Framework APIs rarely expose hinge angles,
  /// so this is advisory — callers must handle `false` gracefully.
  static bool shouldUseTabletop(FoldInfo info) {
    return info.posture == FoldPosture.halfOpened &&
        info.hingeAxis == Axis.horizontal;
  }

  /// Horizontal offset keeping content clear of a vertical hinge.
  ///
  /// Returns 0 when no vertical hinge intersects the window.
  static double hingeAvoidanceOffset(FoldInfo info) {
    if (info.hingeBounds == null) return 0;
    if (info.hingeAxis == Axis.horizontal) return 0;
    return info.hingeBounds!.width;
  }

  /// Minimum region width across [info]'s usable regions.
  static double minRegionWidth(FoldInfo info) =>
      HingeUtils.minRegionWidth(info.availableRegions);
}
