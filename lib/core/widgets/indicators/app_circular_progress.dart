import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppCircularProgress extends StatelessWidget {
  const AppCircularProgress({
    super.key,
    required this.value,
    required this.label,
    this.size,
    this.labelStyle,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 8,
  });

  /// If null, the progress will use the largest square
  /// that fits inside the available parent constraints.
  final double? size;

  /// Progress value between 0.0 and 1.0.
  final double value;

  final String label;

  final TextStyle? labelStyle;

  final Color? backgroundColor;

  final Color? valueColor;

  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedSize = _resolveSize(constraints);

        return SizedBox(
          width: resolvedSize,
          height: resolvedSize,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              value: value.clamp(0.0, 1.0),
              backgroundColor:
                  backgroundColor ?? Theme.of(context).colorScheme.surface,
              valueColor: valueColor ?? Theme.of(context).colorScheme.primary,
              strokeWidth: strokeWidth,
            ),
            child: Center(child: Text(label, style: labelStyle)),
          ),
        );
      },
    );
  }

  double _resolveSize(BoxConstraints constraints) {
    if (size != null) {
      return size!;
    }

    // When size == null, fill the largest square
    // that fits inside the parent's constraints.
    final maxWidth = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : double.infinity;

    final maxHeight = constraints.hasBoundedHeight
        ? constraints.maxHeight
        : double.infinity;

    if (maxWidth.isFinite && maxHeight.isFinite) {
      return math.min(maxWidth, maxHeight);
    }

    if (maxWidth.isFinite) {
      return maxWidth;
    }

    if (maxHeight.isFinite) {
      return maxHeight;
    }

    // No bounded constraint.
    return 96;
  }
}

class _CircularProgressPainter extends CustomPainter {
  const _CircularProgressPainter({
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
    required this.strokeWidth,
  });

  final double value;
  final Color backgroundColor;
  final Color valueColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = valueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background circle.
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc.
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * value,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
