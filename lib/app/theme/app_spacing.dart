import 'package:flutter/widgets.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';

/// Noble Forest - Premium Quranic UI Spacing System
abstract final class AppSpacing {
  /// Base unit: 4px
  static const double xs = 4.0;

  /// Base unit: 8px
  static const double sm = 8.0;

  /// Base unit: 16px
  static const double md = 16.0;

  /// Base unit: 24px
  static const double lg = 24.0;

  /// Base unit: 32px
  static const double xl = 32.0;

  /// Base unit: 40px
  static const double xxl = 40.0;

  /// Base unit: 48px
  static const double xxxl = 48.0;

  /// Section spacing: 64px
  static const double section = 64.0;

  /// Responsive horizontal page padding: 16 / 24 / 32 / 40 / 48.
  ///
  /// Page-level helper; do not make every spacing value responsive —
  /// component-internal gaps should stay visually consistent.
  static EdgeInsets responsivePadding(BuildContext context) {
    final breakpoint = Breakpoints.breakpointOf(
      MediaQuery.sizeOf(context).width,
    );
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return const EdgeInsets.symmetric(horizontal: md);
      case AppBreakpoint.medium:
        return const EdgeInsets.symmetric(horizontal: lg);
      case AppBreakpoint.expanded:
        return const EdgeInsets.symmetric(horizontal: xl);
      case AppBreakpoint.large:
        return const EdgeInsets.symmetric(horizontal: xxl);
      case AppBreakpoint.extraLarge:
        return const EdgeInsets.symmetric(horizontal: xxxl);
    }
  }

  /// Responsive gap: [md] compact, [lg] medium, [xl] expanded+.
  static double responsiveGap(BuildContext context) {
    final breakpoint = Breakpoints.breakpointOf(
      MediaQuery.sizeOf(context).width,
    );
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return md;
      case AppBreakpoint.medium:
        return lg;
      case AppBreakpoint.expanded:
      case AppBreakpoint.large:
      case AppBreakpoint.extraLarge:
        return xl;
    }
  }
}
