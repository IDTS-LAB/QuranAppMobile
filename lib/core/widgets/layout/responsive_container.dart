import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/responsive_layout.dart';

/// Centers content with a breakpoint-aware max width + adaptive padding.
///
/// Defaults prevent excessive line lengths on wide screens while allowing
/// edge-to-edge layouts via [fullWidth]. Safe-area handling stays with
/// page scaffolds — this widget only constrains width and padding.
///
/// ```dart
/// ResponsiveContainer(child: content)
/// ResponsiveContainer(maxWidth: 900, child: content)
/// ```
class ResponsiveContainer extends StatelessWidget {
  /// Creates a width-constrained centered container.
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.fullWidth = false,
    this.constrainOnCompact = false,
  });

  /// Content to constrain.
  final Widget child;

  /// Max content width override (defaults per breakpoint).
  final double? maxWidth;

  /// Horizontal padding override (defaults per breakpoint).
  final EdgeInsetsGeometry? padding;

  /// Alignment of the constrained content.
  final AlignmentGeometry alignment;

  /// When true, skips max-width centering (edge-to-edge).
  final bool fullWidth;

  /// When true, also constrains compact windows (default: full-bleed).
  final bool constrainOnCompact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoints.breakpointOf(constraints.maxWidth);
        if (fullWidth) {
          return Padding(
            padding: padding ?? _defaultPadding(breakpoint),
            child: child,
          );
        }
        final effectiveMax =
            maxWidth ?? ResponsiveLayout.maxContentWidth(breakpoint);
        if (breakpoint == AppBreakpoint.compact && !constrainOnCompact) {
          return Padding(
            padding: padding ?? _defaultPadding(breakpoint),
            child: child,
          );
        }
        return Align(
          alignment: alignment,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: effectiveMax),
            child: Padding(
              padding: padding ?? _defaultPadding(breakpoint),
              child: child,
            ),
          ),
        );
      },
    );
  }

  EdgeInsetsGeometry _defaultPadding(AppBreakpoint breakpoint) {
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppBreakpoint.medium:
        return const EdgeInsets.symmetric(horizontal: 24);
      case AppBreakpoint.expanded:
        return const EdgeInsets.symmetric(horizontal: 32);
      case AppBreakpoint.large:
        return const EdgeInsets.symmetric(horizontal: 40);
      case AppBreakpoint.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 48);
    }
  }
}
