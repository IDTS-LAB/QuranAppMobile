import 'dart:ui' show DisplayFeature;

import 'package:flutter/material.dart';

import '../breakpoints.dart';
import 'hinge_utils.dart';

/// Foldable/window posture.
///
/// `unknown` is the safe fallback when the OS exposes no reliable
/// semantic posture — layouts must then rely on window size + hinge
/// geometry instead of assuming a posture.
enum FoldPosture {
  /// Flat / fully open single region (or non-foldable device).
  flat,

  /// Half-opened (tabletop / book mode). Hinge angle unavailable via
  /// framework APIs; inferred heuristically — treat as advisory.
  halfOpened,

  /// Folded / single small region visible.
  folded,

  /// Fully open / spanned across regions.
  fullyOpen,

  /// Posture could not be determined; use size-based fallback.
  unknown,
}

/// Window configuration snapshot for foldable/adaptive layouts.
///
/// Derive layout from this plus `LayoutBuilder` constraints — never from
/// `screen width == device type` assumptions.
///
/// ```dart
/// final info = context.foldInfo;
/// if (info.isSeparating) { /* two-pane in usable regions */ }
/// ```
class FoldInfo {
  /// Creates a window configuration snapshot.
  const FoldInfo({
    required this.hasDisplayFeature,
    required this.hasHinge,
    required this.isFoldable,
    required this.posture,
    this.hingeAxis,
    this.hingeBounds,
    this.availableRegions = const <Rect>[],
    required this.isSpanned,
    required this.isSeparating,
  });

  /// Any display feature (hinge, fold, cutout) intersects the window.
  final bool hasDisplayFeature;

  /// A hinge/fold feature intersects the window.
  final bool hasHinge;

  /// Device reports foldable features.
  final bool isFoldable;

  /// Best-effort posture; [FoldPosture.unknown] when indeterminable.
  final FoldPosture posture;

  /// Hinge orientation, when a hinge/fold is present.
  final Axis? hingeAxis;

  /// Hinge/fold bounds in window coordinates, if any.
  final Rect? hingeBounds;

  /// Usable regions split around separating features (empty = whole window).
  final List<Rect> availableRegions;

  /// Window spans multiple display regions.
  final bool isSpanned;

  /// A separating feature divides the window into distinct usable regions.
  final bool isSeparating;

  /// No features: standard responsive behavior.
  const FoldInfo.none()
    : hasDisplayFeature = false,
      hasHinge = false,
      isFoldable = false,
      posture = FoldPosture.unknown,
      hingeAxis = null,
      hingeBounds = null,
      availableRegions = const <Rect>[],
      isSpanned = false,
      isSeparating = false;

  /// Reads display features from [MediaQuery] for [context].
  factory FoldInfo.fromContext(BuildContext context) {
    final query = MediaQuery.of(context);
    return FoldInfo.fromFeatures(
      features: query.displayFeatures,
      windowSize: query.size,
    );
  }

  /// Pure constructor from display features + window size (testable).
  factory FoldInfo.fromFeatures({
    required List<DisplayFeature> features,
    required Size windowSize,
  }) {
    if (features.isEmpty) {
      final posture = windowSize.width < Breakpoints.compactMaxWidth
          ? FoldPosture.folded
          : FoldPosture.flat;
      return FoldInfo(
        hasDisplayFeature: false,
        hasHinge: false,
        isFoldable: false,
        posture: posture,
        availableRegions: <Rect>[
          Rect.fromLTWH(0, 0, windowSize.width, windowSize.height),
        ],
        isSpanned: false,
        isSeparating: false,
      );
    }

    final hinge = HingeUtils.findHinge(features);
    final separating = features.any(HingeUtils.isSeparatingFeature);
    final regions = HingeUtils.availableRegions(
      windowSize: windowSize,
      features: features,
    );
    final spanned = regions.length > 1;

    if (hinge == null) {
      // Cutout-only: not a hinge; keep single-pane responsive behavior.
      return FoldInfo(
        hasDisplayFeature: true,
        hasHinge: false,
        isFoldable: false,
        posture: FoldPosture.unknown,
        availableRegions: regions,
        isSpanned: spanned,
        isSeparating: false,
      );
    }

    final axis = HingeUtils.hingeAxis(hinge.bounds);
    final posture = spanned ? FoldPosture.fullyOpen : FoldPosture.folded;
    return FoldInfo(
      hasDisplayFeature: true,
      hasHinge: true,
      isFoldable: true,
      posture: posture,
      hingeAxis: axis,
      hingeBounds: hinge.bounds,
      availableRegions: regions,
      isSpanned: spanned,
      isSeparating: separating,
    );
  }
}
