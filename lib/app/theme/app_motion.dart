import 'package:flutter/material.dart';

/// Centralized motion tokens (durations + curves).
///
/// Keeps posture changes, navigation transitions, and micro-interactions
/// consistent. Honors reduced-motion via [MediaQuery.disableAnimations]
/// at call sites where relevant.
abstract final class AppMotion {
  /// Instant feedback (ripples, icon toggles).
  static const Duration fast = Duration(milliseconds: 120);

  /// Default transition (page fades, pane switches, scroll-to-ayah).
  static const Duration normal = Duration(milliseconds: 300);

  /// Emphasized transitions (sheet entrance, layout reflow).
  static const Duration slow = Duration(milliseconds: 500);

  /// Standard easing for entrances.
  static const Curve easeOut = Curves.easeOutCubic;

  /// Standard easing for exits.
  static const Curve easeIn = Curves.easeInCubic;

  /// Default combined easing.
  static const Curve standard = Curves.easeInOutCubic;
}
