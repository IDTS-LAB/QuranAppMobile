import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_elevation.dart';

/// Noble Forest - Premium Quranic UI Floating Action Button Component
///
/// Reference:
/// - Noble Gold
/// - white icon
/// - circular
/// - subtle shadow
///
/// [semanticLabel] is exposed to screen readers (previously accepted but
/// ignored); [tooltip] shows the long-press hint.
class AppFloatingActionButton extends StatelessWidget {
  /// Creates a floating action button with theme-derived defaults.
  const AppFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
    this.semanticLabel,
    this.enabled = true,
    this.mini = false,
  });

  /// Button content (typically an [Icon]).
  final Widget child;

  /// Press handler.
  final VoidCallback? onPressed;

  /// Long-press hint.
  final String? tooltip;

  /// Screen-reader label.
  final String? semanticLabel;

  /// Disabled state.
  final bool enabled;

  /// Mini variant.
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: enabled && onPressed != null,
      label: semanticLabel,
      child: FloatingActionButton(
        onPressed: enabled ? onPressed : null,
        tooltip: tooltip,
        foregroundColor: AppColors.surface,
        backgroundColor: AppColors.nobleGold,
        elevation: AppElevation.level2,
        shape: const CircleBorder(),
        mini: mini,
        child: child,
      ),
    );
  }
}
