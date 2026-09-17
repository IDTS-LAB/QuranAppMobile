import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Noble Forest - Premium Quranic UI Divider Component
///
/// Characteristics:
/// - 1px
/// - subtle border color
/// - low visual prominence
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.thickness = 1,
    this.color,
    this.height,
    this.indent = 0,
    this.endIndent = 0,
  });

  final double thickness;
  final Color? color;
  final double? height;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: color ?? AppColors.border,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
