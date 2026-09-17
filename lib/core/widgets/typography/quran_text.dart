import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Noble Forest - Premium Quranic UI Quran Text Component
///
/// Properties:
/// - text
/// - style
/// - fontSize
/// - lineHeight
/// - textAlign
/// - textDirection
/// - color
/// - maxLines
/// - overflow
///
/// Support:
/// - RTL
/// - Arabic shaping
/// - dynamic font size
/// - dynamic line height
///
/// Quran text must remain visually dominant over UI controls.
class QuranText extends StatelessWidget {
  const QuranText({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.lineHeight,
    this.textAlign,
    this.textDirection = TextDirection.rtl,
    this.color,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final double? fontSize;
  final double? lineHeight;
  final TextAlign? textAlign;
  final TextDirection textDirection;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle =
        style ??
        TextStyle(
          fontSize: fontSize,
          height: lineHeight,
          color: color ?? AppColors.textPrimary,
        );

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      // Ensure proper Arabic shaping and text direction
      textScaler: MediaQuery.of(context).textScaler.clamp(
        maxScaleFactor: .8, // Prevent text from becoming too small
        minScaleFactor: .0, // Prevent text from becoming too large
      ),
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        leading: 0.2, // Extra leading for Arabic text
      ),
    );
  }
}
