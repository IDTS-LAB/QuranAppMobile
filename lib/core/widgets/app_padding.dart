import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_spacing.dart';

/// Noble Forest - Premium Quranic UI Padding Container Component
///
/// A simple container that applies consistent padding to its children.
/// Eliminates the need for manual Padding widgets throughout the application.
///
/// Usage:
/// ```dart
/// AppPadding(
///   child: MyWidget(),
/// )
///
/// // With custom padding
/// AppPadding(
///   padding: EdgeInsets.all(AppSpacing.lg),
///   child: MyWidget(),
/// )
///
/// // To control width (e.g., not full width)
/// AppPadding(
///   width: 300,
///   child: MyWidget(),
/// )
/// ```
class AppPadding extends StatelessWidget {
  const AppPadding({
    super.key,
    this.child,
    this.padding,
    this.width,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Widget padded = Padding(
      padding: padding ?? EdgeInsets.all(AppSpacing.md),
      child: child,
    );

    if (width == null) {
      return padded;
    }

    return SizedBox(
      width: width,
      child: padded,
    );
  }
}
