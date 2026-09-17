import 'package:flutter/material.dart';

/// Noble Forest - Adaptive Text Widget
///
/// Automatically scales font size based on screen width to provide
/// responsive typography without manual font size specification.
///
/// Usage:
///   AdaptiveText('Hello World', style: AppTypography.bodyMedium)
///
/// The text will scale proportionally to the screen width relative to
/// a base width of 360dp (typical mobile width), with sensible clamping.
class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap = true,
    this.textOverflow = TextOverflow.clip,
    this.maxLines,
    this.baseWidth = 360.0, // Reference width for scaling
    this.minScale = 0.8,
    this.maxScale = 2.0,
  });

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow textOverflow;
  final int? maxLines;
  final double baseWidth;
  final double minScale;
  final double maxScale;

  @override
  Widget build(BuildContext context) {
    // Get base style from provided style or default text style
    final TextStyle baseStyle = style ?? DefaultTextStyle.of(context).style;
    final double baseFontSize = baseStyle.fontSize ?? 14.0;

    // Calculate width-based scale factor
    final double screenWidth = MediaQuery.of(context).size.width;
    final double widthScale = (screenWidth / baseWidth).clamp(minScale, maxScale);

    // Apply user's accessibility text scaling
    final double textScale = MediaQuery.of(context).textScaler.scale(1.0);
    final double combinedScale = (widthScale * textScale).clamp(minScale, maxScale);

    // Calculate final font size
    final double finalFontSize = baseFontSize * combinedScale;

    // Create the final text style
    final TextStyle finalStyle = baseStyle.copyWith(
      fontSize: finalFontSize,
      height: baseStyle.height,
      fontWeight: baseStyle.fontWeight,
      fontStyle: baseStyle.fontStyle,
      letterSpacing: baseStyle.letterSpacing,
      wordSpacing: baseStyle.wordSpacing,
    );

    return Text(
      data,
      style: finalStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}