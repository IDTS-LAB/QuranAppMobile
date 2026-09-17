import 'package:flutter/material.dart';
import 'package:quran_app/app/theme/app_radius.dart';

import 'package:quran_app/app/theme/app_colors.dart';

/// Noble Forest - Premium Quranic UI Icon Button Component
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.semanticLabel,
    this.selected = false,
    this.enabled = true,
    this.size = 24,
    this.color,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? semanticLabel;
  final bool selected;
  final bool enabled;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && onPressed != null;
    final Color iconColor =
        color ??
        (selected
            ? AppColors.nobleGreen
            : isEnabled
            ? AppColors.textPrimary
            : AppColors.disabled);

    return IconButton(
      icon: icon,
      onPressed: isEnabled ? onPressed : null,
      tooltip: tooltip,
      color: iconColor,
      iconSize: size,
      splashRadius: size * 0.6,
      constraints: BoxConstraints(
        minWidth: 48, // Minimum touch target
        minHeight: 48, // Minimum touch target
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        backgroundColor: selected ? AppColors.nobleGreen : Colors.transparent,
      ),
    );
  }
}
