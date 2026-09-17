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
    // Determine base style from provided style or default
    final TextStyle baseStyle = style ?? TextStyle();

    // Determine base font size for calculation
    double baseFontSize;
    if (fontSize != null) {
      // Explicit font size provided - use as-is (non-adaptive)
      baseFontSize = fontSize!;
    } else if (baseStyle.fontSize != null) {
      // Font size provided in style - use as-is (non-adaptive)
      baseFontSize = baseStyle.fontSize!;
    } else {
      // No font size specified - use size enum to get base size for adaptive scaling
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

    // Calculate adaptive scale factor based on screen width and user accessibility settings
    final double screenWidth = MediaQuery.of(context).size.width;
    final double widthScale = (screenWidth / 360.0).clamp(
      0.8,
      2.0,
    ); // Base width 360dp
    final double textScale = MediaQuery.of(context).textScaler.scale(1.0);
    final double combinedScale = (widthScale * textScale).clamp(0.8, 2.0);
    final double finalFontSize = baseFontSize * combinedScale;

    // Create final text style by merging base style with adaptive font size and other parameters
    final TextStyle finalStyle = baseStyle.copyWith(
      fontSize: finalFontSize,
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
