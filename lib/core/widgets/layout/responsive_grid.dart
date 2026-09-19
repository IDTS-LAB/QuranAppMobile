import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/responsive_layout.dart';

/// Grid with automatic column count from available width.
///
/// Columns = f(width, [minItemWidth], [maxColumns], [spacing]).
/// Defaults suit menu/dashboard cards; override for dense lists.
///
/// ```dart
/// ResponsiveGrid(children: items)
/// ResponsiveGrid(minItemWidth: 160, maxColumns: 4, spacing: 16, children: items)
/// ```
class ResponsiveGrid extends StatelessWidget {
  /// Creates an auto-column grid.
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 160,
    this.maxColumns = 4,
    this.spacing = 16,
    this.runSpacing,
    this.childAspectRatio = 1.2,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  /// Grid items.
  final List<Widget> children;

  /// Minimum item width driving column count.
  final double minItemWidth;

  /// Maximum columns regardless of width.
  final int maxColumns;

  /// Horizontal and (default) vertical spacing.
  final double spacing;

  /// Vertical spacing override (defaults to [spacing]).
  final double? runSpacing;

  /// Child width/height ratio.
  final double childAspectRatio;

  /// Outer padding.
  final EdgeInsetsGeometry? padding;

  /// Shrink-wrap for use inside scrollables.
  final bool shrinkWrap;

  /// Scroll physics (set `NeverScrollableScrollPhysics` inside parents).
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = ResponsiveLayout.columnsForWidth(
          constraints.maxWidth,
          minItemWidth: minItemWidth,
          maxColumns: maxColumns,
          spacing: spacing,
        );
        return GridView.builder(
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: runSpacing ?? spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
