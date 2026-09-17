import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Noble Forest - Premium Quranic UI Floating Action Button Component
///
/// Reference:
/// - Noble Gold
/// - white icon
/// - circular
/// - subtle shadow
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
    this.semanticLabel,
    this.enabled = true,
    this.mini = false,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? semanticLabel;
  final bool enabled;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: enabled ? onPressed : null,
      tooltip: tooltip,
      foregroundColor: AppColors.surface,
      backgroundColor: AppColors.nobleGold,
      elevation: 2,
      shape: const CircleBorder(),
      mini: mini,
      child: child,
    );
  }
}
