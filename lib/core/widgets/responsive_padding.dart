import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/responsive/adaptive_layout.dart';

/// Noble Forest - Premium Quranic UI Responsive Padding Container Component
///
/// A container that applies responsive padding based on screen size.
/// Eliminates the need for manual Padding widgets and responsive calculations.
///
/// Usage:
/// ```dart
/// ResponsivePadding(
///   child: MyWidget(),
/// )
///
/// // With custom padding values for each size
/// ResponsivePadding(
///   padding: const ResponsivePaddingValues(
///     compact: EdgeInsets.all(16.0),
///     medium: EdgeInsets.all(24.0),
///     expanded: EdgeInsets.all(32.0),
///   ),
///   child: MyWidget(),
/// )
///
/// // To control width (e.g., not full width)
/// ResponsivePadding(
///   width: 300,
///   child: MyWidget(),
/// )
/// ```
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({super.key, this.child, this.padding, this.width});

  final Widget? child;
  final ResponsivePaddingValues? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout.builder(
      builder: (context, size) {
        final EdgeInsetsGeometry effectivePadding =
            padding?.resolve(size) ?? _defaultPadding(size);
        final Widget padded = Padding(padding: effectivePadding, child: child);

        if (width == null) {
          return padded;
        }

        return SizedBox(width: width, child: padded);
      },
    );
  }

  EdgeInsetsGeometry _defaultPadding(AdaptiveSize size) {
    switch (size) {
      case AdaptiveSize.compact:
        return EdgeInsets.all(AppSpacing.md); // 16px
      case AdaptiveSize.medium:
        return EdgeInsets.all(AppSpacing.lg); // 24px
      case AdaptiveSize.expanded:
        return EdgeInsets.all(AppSpacing.xl); // 32px
    }
  }
}

/// Defines padding values for different adaptive sizes.
class ResponsivePaddingValues {
  const ResponsivePaddingValues({
    required this.compact,
    required this.medium,
    required this.expanded,
  });

  final EdgeInsetsGeometry compact;
  final EdgeInsetsGeometry medium;
  final EdgeInsetsGeometry expanded;

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
}
