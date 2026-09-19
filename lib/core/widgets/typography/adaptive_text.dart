import 'package:flutter/material.dart';

/// Theme-based text with controlled responsive adjustments.
///
/// Unlike the previous width-scaling implementation, this does NOT scale
/// fonts by screen width (which harms readability consistency). It renders
/// the given [style] (or ambient default) and lets the framework apply the
/// user's text-scaler / accessibility settings. Use [ResponsiveValue] at
/// call sites for the rare cases needing breakpoint-specific styles.
///
/// ```dart
/// AdaptiveText('Hello', style: AppTypography.bodyMedium)
/// ```
class AdaptiveText extends StatelessWidget {
  /// Creates theme-based adaptive text.
  const AdaptiveText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap = true,
    this.textOverflow = TextOverflow.clip,
    this.maxLines,
    @Deprecated('Width scaling removed; accepted for API compatibility.')
    this.baseWidth = 360.0,
    @Deprecated('Width scaling removed; accepted for API compatibility.')
    this.minScale = 0.8,
    @Deprecated('Width scaling removed; accepted for API compatibility.')
    this.maxScale = 2.0,
  });

  /// Text content.
  final String data;

  /// Base style (theme-derived recommended).
  final TextStyle? style;

  /// Horizontal alignment.
  final TextAlign? textAlign;

  /// Text direction override (RTL supported via ambient directionality).
  final TextDirection? textDirection;

  /// Whether text wraps.
  final bool softWrap;

  /// Overflow behavior (prefer ellipsis/clip with maxLines for fixed areas).
  final TextOverflow textOverflow;

  /// Maximum lines.
  final int? maxLines;

  /// Legacy width-scaling params (ignored, kept for compatibility).
  final double baseWidth;

  /// Legacy width-scaling params (ignored, kept for compatibility).
  final double minScale;

  /// Legacy width-scaling params (ignored, kept for compatibility).
  final double maxScale;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
