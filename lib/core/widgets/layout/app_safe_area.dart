import 'package:flutter/material.dart';

/// Clear safe-area responsibilities: page scaffolds own system insets.
///
/// Reusable cards must NOT apply safe-area padding; navigation components
/// handle their own insets. Use this at page level to opt into/out of
/// edge-to-edge behavior explicitly.
///
/// ```dart
/// AppSafeArea(child: content) // top+bottom+left+right
/// AppSafeArea(top: false, child: fullBleedHeader)
/// ```
class AppSafeArea extends StatelessWidget {
  /// Creates an explicit safe-area wrapper.
  const AppSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  });

  /// Content.
  final Widget child;

  /// Whether to avoid the top system intrustion.
  final bool top;

  /// Whether to avoid the bottom system intrusion.
  final bool bottom;

  /// Whether to avoid the left system intrusion.
  final bool left;

  /// Whether to avoid the right system intrusion.
  final bool right;

  /// Additional minimum padding.
  final EdgeInsets minimum;

  /// Maintains bottom padding when the keyboard shows.
  final bool maintainBottomViewPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}
