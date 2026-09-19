import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

/// Pure helpers for hinge/fold/cutout display features.
///
/// All methods are pure (no [BuildContext]) so hinge detection, region
/// math, and pane decisions are unit-testable with simulated
/// [DisplayFeature] configurations.
abstract final class HingeUtils {
  /// True when [feature] is a hinge or fold (not a camera cutout).
  static bool isHingeFeature(DisplayFeature feature) {
    return feature.type == DisplayFeatureType.hinge ||
        feature.type == DisplayFeatureType.fold;
  }

  /// True when [feature] separates the window into distinct regions.
  ///
  /// Only `unknown`-state features are non-separating; cutouts never
  /// separate regardless of state.
  static bool isSeparatingFeature(DisplayFeature feature) {
    if (!isHingeFeature(feature)) return false;
    return feature.state != DisplayFeatureState.unknown;
  }

  /// First hinge/fold feature, or null when the list has none.
  static DisplayFeature? findHinge(List<DisplayFeature> features) {
    for (final feature in features) {
      if (isHingeFeature(feature)) return feature;
    }
    return null;
  }

  /// Hinge orientation from its bounds: tall+narrow = vertical.
  static Axis hingeAxis(Rect bounds) =>
      bounds.width < bounds.height ? Axis.vertical : Axis.horizontal;

  /// Usable regions after splitting around separating features.
  ///
  /// Non-separating features (cutouts) are ignored. Returns a single
  /// full-window region when nothing separates.
  static List<Rect> availableRegions({
    required Size windowSize,
    required List<DisplayFeature> features,
  }) {
    var regions = <Rect>[
      Rect.fromLTWH(0, 0, windowSize.width, windowSize.height),
    ];
    for (final feature in features) {
      if (!isSeparatingFeature(feature)) continue;
      final next = <Rect>[];
      for (final region in regions) {
        next.addAll(_splitRegion(region, feature.bounds));
      }
      regions = next;
    }
    return regions;
  }

  /// Splits [region] around [obstacle], dropping zero-area pieces.
  static List<Rect> _splitRegion(Rect region, Rect obstacle) {
    final intersection = region.intersect(obstacle);
    if (intersection.isEmpty) return <Rect>[region];
    final vertical = obstacle.width < obstacle.height;
    if (vertical) {
      return <Rect>[
        Rect.fromLTRB(
          region.left,
          region.top,
          intersection.left,
          region.bottom,
        ),
        Rect.fromLTRB(
          intersection.right,
          region.top,
          region.right,
          region.bottom,
        ),
      ].where((r) => r.width > 1 && r.height > 1).toList();
    }
    return <Rect>[
      Rect.fromLTRB(region.left, region.top, region.right, intersection.top),
      Rect.fromLTRB(
        region.left,
        intersection.bottom,
        region.right,
        region.bottom,
      ),
    ].where((r) => r.width > 1 && r.height > 1).toList();
  }

  /// Narrowest usable region width (0 when [regions] is empty).
  static double minRegionWidth(List<Rect> regions) {
    if (regions.isEmpty) return 0;
    var min = double.infinity;
    for (final r in regions) {
      if (r.width < min) min = r.width;
    }
    return min;
  }

  /// Whether [point] lies inside [hingeBounds] (with optional [padding]).
  static bool isUnderHinge(
    Offset point,
    Rect? hingeBounds, {
    double padding = 0,
  }) {
    if (hingeBounds == null) return false;
    final expanded = hingeBounds.inflate(padding);
    return expanded.contains(point);
  }
}
