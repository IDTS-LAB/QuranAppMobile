import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/foldable/fold_info.dart';

/// Avoids hinge overlap; stacks content/controls in half-open posture.
///
/// Default behavior: normal layout when no fold exists; horizontal-hinge
/// half-open splits [child] above and [secondary] below the hinge;
/// vertical separating hinges add clearance so interactive content never
/// renders underneath the hinge.
///
/// ```dart
/// FoldAwareLayout(child: content)
/// FoldAwareLayout(child: video, secondary: controls)
/// ```
class FoldAwareLayout extends StatelessWidget {
  /// Creates a hinge-aware wrapper.
  const FoldAwareLayout({
    super.key,
    required this.child,
    this.secondary,
    this.avoidHinge = true,
    this.respectSafeAreas = true,
  });

  /// Primary content.
  final Widget child;

  /// Optional secondary content shown below the hinge in tabletop mode.
  final Widget? secondary;

  /// Adds clearance around hinge bounds when separating.
  final bool avoidHinge;

  /// Wraps panes in [SafeArea].
  final bool respectSafeAreas;

  @override
  Widget build(BuildContext context) {
    final info = FoldInfo.fromContext(context);

    // Half-open + horizontal hinge + secondary: tabletop stacking.
    if (info.posture == FoldPosture.halfOpened &&
        info.hingeAxis == Axis.horizontal &&
        info.hingeBounds != null &&
        secondary != null) {
      final top = respectSafeAreas
          ? SafeArea(bottom: false, child: child)
          : child;
      final bottom = respectSafeAreas
          ? SafeArea(top: false, child: secondary!)
          : secondary!;
      return Column(
        children: <Widget>[
          Expanded(child: top),
          SizedBox(height: info.hingeBounds!.height),
          Expanded(child: bottom),
        ],
      );
    }

    // Vertical separating hinge: keep content clear of the hinge strip.
    if (avoidHinge &&
        info.isSeparating &&
        info.hingeAxis == Axis.vertical &&
        info.hingeBounds != null) {
      final content = respectSafeAreas ? SafeArea(child: child) : child;
      return Row(
        children: <Widget>[
          Expanded(child: content),
          SizedBox(width: info.hingeBounds!.width),
        ],
      );
    }

    if (respectSafeAreas) return SafeArea(child: child);
    return child;
  }
}
