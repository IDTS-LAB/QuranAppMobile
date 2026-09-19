import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/responsive/adaptive_layout.dart';
import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/responsive_value.dart';

/// Responsive padding with sensible 5-breakpoint defaults.
///
/// Defaults: compact 16 / medium 24 / expanded 32 / large 40 / extraLarge 48
/// (horizontal; vertical defaults to 0 — pass [vertical] or full overrides).
///
/// ```dart
/// ResponsivePadding(child: content)
/// ResponsivePadding(compact: EdgeInsets.all(12), child: content)
/// ```
class ResponsivePadding extends StatelessWidget {
  /// Creates responsive padding around [child].
  const ResponsivePadding({
    super.key,
    this.child,
    this.padding,
    this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    this.horizontal,
    this.vertical,
    this.width,
  });

  /// Optional child.
  final Widget? child;

  /// Full per-size override (legacy API, still supported).
  final ResponsivePaddingValues? padding;

  /// Per-breakpoint overrides (individual axis customization).
  final EdgeInsetsGeometry? compact;

  /// Per-breakpoint override for medium windows.
  final EdgeInsetsGeometry? medium;

  /// Per-breakpoint override for expanded windows.
  final EdgeInsetsGeometry? expanded;

  /// Per-breakpoint override for large windows.
  final EdgeInsetsGeometry? large;

  /// Per-breakpoint override for extra-large windows.
  final EdgeInsetsGeometry? extraLarge;

  /// Shorthand horizontal padding applied to every breakpoint.
  final double? horizontal;

  /// Shorthand vertical padding applied to every breakpoint.
  final double? vertical;

  /// Optional width constraint wrapper.
  final double? width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = Breakpoints.breakpointOf(constraints.maxWidth);
        final effective = _resolve(breakpoint);
        final padded = Padding(padding: effective, child: child);
        if (width == null) return padded;
        return SizedBox(width: width, child: padded);
      },
    );
  }

  EdgeInsetsGeometry _resolve(AppBreakpoint breakpoint) {
    final table = ResponsiveValue<EdgeInsetsGeometry>(
      compact:
          compact ??
          padding?.compact ??
          _withAxis(const EdgeInsets.symmetric(horizontal: AppSpacing.md)),
      medium:
          medium ??
          padding?.medium ??
          _withAxis(const EdgeInsets.symmetric(horizontal: AppSpacing.lg)),
      expanded:
          expanded ??
          padding?.expanded ??
          _withAxis(const EdgeInsets.symmetric(horizontal: AppSpacing.xl)),
      large:
          large ??
          padding?.large ??
          _withAxis(const EdgeInsets.symmetric(horizontal: AppSpacing.xxl)),
      extraLarge:
          extraLarge ??
          padding?.extraLarge ??
          _withAxis(const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl)),
    );
    return table.resolveFor(breakpoint);
  }

  EdgeInsetsGeometry _withAxis(EdgeInsetsGeometry base) {
    if (horizontal == null && vertical == null) return base;
    final baseInsets = base.resolve(TextDirection.ltr);
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? baseInsets.left,
      vertical: vertical ?? baseInsets.top,
    );
  }

  /// Default padding for an [AdaptiveSize] (legacy helper).
  EdgeInsetsGeometry defaultPadding(AdaptiveSize size) {
    switch (size) {
      case AdaptiveSize.compact:
        return const EdgeInsets.all(AppSpacing.md);
      case AdaptiveSize.medium:
        return const EdgeInsets.all(AppSpacing.lg);
      case AdaptiveSize.expanded:
        return const EdgeInsets.all(AppSpacing.xl);
    }
  }
}

/// Per-size padding values (legacy API; `large`/`extraLarge` optional).
class ResponsivePaddingValues {
  /// Creates per-size padding values.
  const ResponsivePaddingValues({
    required this.compact,
    required this.medium,
    required this.expanded,
    this.large,
    this.extraLarge,
  });

  /// Padding for compact windows.
  final EdgeInsetsGeometry compact;

  /// Padding for medium windows.
  final EdgeInsetsGeometry medium;

  /// Padding for expanded windows.
  final EdgeInsetsGeometry expanded;

  /// Padding for large windows (falls back to [expanded]).
  final EdgeInsetsGeometry? large;

  /// Padding for extra-large windows (falls back toward [expanded]).
  final EdgeInsetsGeometry? extraLarge;

  /// Resolves for a legacy [AdaptiveSize].
  EdgeInsetsGeometry resolve(AdaptiveSize size) {
    switch (size) {
      case AdaptiveSize.compact:
        return compact;
      case AdaptiveSize.medium:
        return medium;
      case AdaptiveSize.expanded:
        return expanded;
    }
  }

  /// Resolves for a full [AppBreakpoint].
  EdgeInsetsGeometry resolveBreakpoint(AppBreakpoint breakpoint) {
    return ResponsiveValue<EdgeInsetsGeometry>(
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
      extraLarge: extraLarge,
    ).resolveFor(breakpoint);
  }
}
