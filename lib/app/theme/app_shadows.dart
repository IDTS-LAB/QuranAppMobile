import 'package:flutter/material.dart';

/// Noble Forest - Premium Quranic UI Shadows System
abstract final class AppShadows {
  /// No shadow
  static const List<BoxShadow> none = [];

  /// Subtle depth shadow
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Medium depth shadow
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  /// Floating UI shadow
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.12),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
}
