import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';

/// Direction-switching flex row/column with spacing.
///
/// Renders [children] vertically on compact windows and horizontally once
/// [breakpoint] is reached (defaults to expanded). Spacing is applied
/// between children without trailing gaps; defaults prevent overflow by
/// wrapping flex children with [Flexible] when horizontal.
///
/// ```dart
/// ResponsiveFlex(
///   compactDirection: Axis.vertical,
///   expandedDirection: Axis.horizontal,
///   spacing: 16,
///   children: [WidgetA(), WidgetB()],
/// );
/// ```
class ResponsiveFlex extends StatelessWidget {
  /// Creates a direction-switching flex.
  const ResponsiveFlex({
    super.key,
    required this.children,
    this.compactDirection = Axis.vertical,
    this.expandedDirection = Axis.horizontal,
    this.breakpoint = AppBreakpoint.expanded,
    this.spacing = 16,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.wrapChildren = true,
  });

  /// Children laid out along the resolved direction.
  final List<Widget> children;

  /// Direction below [breakpoint].
  final Axis compactDirection;

  /// Direction at/above [breakpoint].
  final Axis expandedDirection;

  /// Breakpoint where direction switches.
  final AppBreakpoint breakpoint;

  /// Gap between children.
  final double spacing;

  /// Main-axis alignment.
  final MainAxisAlignment mainAxisAlignment;

  /// Cross-axis alignment.
  final CrossAxisAlignment crossAxisAlignment;

  /// Main-axis size.
  final MainAxisSize mainAxisSize;

  /// Wrap children in [Flexible] when horizontal (prevents overflow).
  final bool wrapChildren;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bp = Breakpoints.breakpointOf(constraints.maxWidth);
        final direction = bp.index >= breakpoint.index
            ? expandedDirection
            : compactDirection;
        final spaced = _withSpacing(children, direction);
        if (direction == Axis.horizontal) {
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: wrapChildren
                ? [for (final w in spaced) Flexible(child: w)]
                : spaced,
          );
        }
        return Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: spaced,
        );
      },
    );
  }

  List<Widget> _withSpacing(List<Widget> items, Axis direction) {
    if (items.isEmpty || spacing == 0) return items;
    final gap = direction == Axis.horizontal
        ? SizedBox(width: spacing)
        : SizedBox(height: spacing);
    final out = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      out.add(items[i]);
      if (i < items.length - 1) out.add(gap);
    }
    return out;
  }
}
