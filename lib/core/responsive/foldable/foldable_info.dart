import 'dart:ui' show DisplayFeature, DisplayFeatureType;

import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';

/// Foldable posture derived from display features.
///
/// The exact hinge angle requires a platform sensor plugin (follow-up);
/// until then [halfOpen] is reserved and posture is inferred from the
/// display configuration: single compact screen reads as folded, a spanned
/// dual-screen window reads as fully open.
enum FoldablePosture { folded, halfOpen, fullyOpen, unknown }

/// Display configuration snapshot for foldable/adaptive layouts.
///
/// Always derive layout from this (plus [LayoutBuilder] constraints),
/// never from `screen width == device type` assumptions.
class FoldableInfo {
  const FoldableInfo({
    required this.hasHinge,
    required this.isDualScreen,
    required this.posture,
    this.hingeBounds,
  });

  /// Whether a hinge/fold display feature intersects the window.
  final bool hasHinge;

  /// Whether the window spans two display regions separated by a hinge.
  final bool isDualScreen;

  /// Inferred posture; see [FoldablePosture] for limitations.
  final FoldablePosture posture;

  /// Bounds of the hinge/fold feature, if any. Keep interactive content
  /// clear of this region.
  final Rect? hingeBounds;

  /// Reads display features from [MediaQuery] for [context].
  factory FoldableInfo.fromContext(BuildContext context) {
    final List<DisplayFeature> features =
        MediaQuery.of(context).displayFeatures;
    Rect? hinge;
    for (final feature in features) {
      if (feature.type == DisplayFeatureType.hinge ||
          feature.type == DisplayFeatureType.fold) {
        hinge = feature.bounds;
        break;
      }
    }
    if (hinge == null) {
      final double width = MediaQuery.of(context).size.width;
      return FoldableInfo(
        hasHinge: false,
        isDualScreen: false,
        posture: width < Breakpoints.compactMaxWidth ? FoldablePosture.folded : FoldablePosture.unknown,
      );
    }
    final Size size = MediaQuery.of(context).size;
    final bool verticalHinge = hinge.width < hinge.height;
    final bool spansBoth = verticalHinge
        ? hinge.left > 0 && hinge.right < size.width
        : hinge.top > 0 && hinge.bottom < size.height;
    return FoldableInfo(
      hasHinge: true,
      isDualScreen: spansBoth,
      hingeBounds: hinge,
      posture: spansBoth ? FoldablePosture.fullyOpen : FoldablePosture.folded,
    );
  }
}
