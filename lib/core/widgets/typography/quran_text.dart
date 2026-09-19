import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_colors.dart';

/// Noble Forest - Quran Text Size Enum
enum QuranTextSize { large, medium, small }

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
/// - size (for adaptive sizing when fontSize is not specified)
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
    this.size = QuranTextSize.medium,
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
  final QuranTextSize size;

  @override
  Widget build(BuildContext context) {
    // Determine base style from provided style or default.
    // Semantic sizes only — no screen-width scaling (readability stays
    // consistent; the framework applies the user's text-scaler).
    final TextStyle baseStyle = style ?? const TextStyle();

    double baseFontSize;
    if (fontSize != null) {
      baseFontSize = fontSize!;
    } else if (baseStyle.fontSize != null) {
      baseFontSize = baseStyle.fontSize!;
    } else {
      switch (size) {
        case QuranTextSize.large:
          baseFontSize = 24.0;
          break;
        case QuranTextSize.medium:
          baseFontSize = 20.0;
          break;
        case QuranTextSize.small:
          baseFontSize = 18.0;
          break;
      }
    }

    // Create final text style by merging base style with font size and other parameters
    final TextStyle finalStyle = baseStyle.copyWith(
      fontSize: baseFontSize,
      height: lineHeight ?? baseStyle.height ?? 2.2,
      color: color ?? baseStyle.color ?? AppColors.textPrimary,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      // Ensure proper Arabic shaping and text direction
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        leading: 0.2, // Extra leading for Arabic text
      ),
    );
  }
}
