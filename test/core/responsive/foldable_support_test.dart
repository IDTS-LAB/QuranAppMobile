import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/responsive/foldable/fold_info.dart';
import 'package:quran_app/core/responsive/foldable/foldable_layout.dart';
import 'package:quran_app/core/responsive/foldable/hinge_utils.dart';

DisplayFeature hinge({
  required Rect bounds,
  DisplayFeatureState state = DisplayFeatureState.postureFlat,
}) => DisplayFeature(
  bounds: bounds,
  type: DisplayFeatureType.hinge,
  state: state,
);

DisplayFeature cutout({required Rect bounds}) => DisplayFeature(
  bounds: bounds,
  type: DisplayFeatureType.cutout,
  state: DisplayFeatureState.unknown,
);

void main() {
  group('HingeUtils', () {
    test('distinguishes hinges from cutouts', () {
      expect(
        HingeUtils.isHingeFeature(
          hinge(bounds: const Rect.fromLTWH(400, 0, 10, 800)),
        ),
        isTrue,
      );
      expect(
        HingeUtils.isHingeFeature(
          cutout(bounds: const Rect.fromLTWH(180, 0, 40, 20)),
        ),
        isFalse,
      );
    });

    test('only non-unknown hinge states separate', () {
      expect(
        HingeUtils.isSeparatingFeature(
          hinge(
            bounds: const Rect.fromLTWH(400, 0, 10, 800),
            state: DisplayFeatureState.unknown,
          ),
        ),
        isFalse,
      );
      expect(
        HingeUtils.isSeparatingFeature(
          hinge(bounds: const Rect.fromLTWH(400, 0, 10, 800)),
        ),
        isTrue,
      );
      expect(
        HingeUtils.isSeparatingFeature(
          cutout(bounds: const Rect.fromLTWH(180, 0, 40, 20)),
        ),
        isFalse,
      );
    });

    test('hingeAxis detects orientation', () {
      expect(
        HingeUtils.hingeAxis(const Rect.fromLTWH(400, 0, 10, 800)),
        Axis.vertical,
      );
      expect(
        HingeUtils.hingeAxis(const Rect.fromLTWH(0, 400, 800, 10)),
        Axis.horizontal,
      );
    });

    test('availableRegions splits around a vertical hinge', () {
      final regions = HingeUtils.availableRegions(
        windowSize: const Size(800, 600),
        features: [hinge(bounds: const Rect.fromLTWH(395, 0, 10, 600))],
      );
      expect(regions, hasLength(2));
      expect(regions[0].width, closeTo(395, 0.001));
      expect(regions[1].width, closeTo(395, 0.001));
    });

    test('availableRegions ignores cutouts', () {
      final regions = HingeUtils.availableRegions(
        windowSize: const Size(400, 800),
        features: [cutout(bounds: const Rect.fromLTWH(180, 0, 40, 20))],
      );
      expect(regions, hasLength(1));
    });

    test('isUnderHinge detects overlap', () {
      const bounds = Rect.fromLTWH(395, 0, 10, 600);
      expect(HingeUtils.isUnderHinge(const Offset(400, 300), bounds), isTrue);
      expect(HingeUtils.isUnderHinge(const Offset(100, 100), bounds), isFalse);
      expect(HingeUtils.isUnderHinge(const Offset(100, 100), null), isFalse);
    });
  });

  group('FoldInfo.fromFeatures', () {
    test('no features on a phone reads as folded', () {
      final info = FoldInfo.fromFeatures(
        features: const [],
        windowSize: const Size(400, 800),
      );
      expect(info.hasHinge, isFalse);
      expect(info.isSpanned, isFalse);
      expect(info.isSeparating, isFalse);
      expect(info.posture, FoldPosture.folded);
      expect(info.availableRegions, hasLength(1));
    });

    test('no features on a tablet reads as flat', () {
      final info = FoldInfo.fromFeatures(
        features: const [],
        windowSize: const Size(1200, 800),
      );
      expect(info.posture, FoldPosture.flat);
    });

    test('spanned hinge reads as fully open + separating', () {
      final info = FoldInfo.fromFeatures(
        windowSize: const Size(800, 600),
        features: [hinge(bounds: const Rect.fromLTWH(395, 0, 10, 600))],
      );
      expect(info.hasHinge, isTrue);
      expect(info.isFoldable, isTrue);
      expect(info.isSpanned, isTrue);
      expect(info.isSeparating, isTrue);
      expect(info.posture, FoldPosture.fullyOpen);
      expect(info.hingeAxis, Axis.vertical);
      expect(info.hingeBounds, const Rect.fromLTWH(395, 0, 10, 600));
      expect(info.availableRegions, hasLength(2));
    });

    test('cutout-only never separates', () {
      final info = FoldInfo.fromFeatures(
        windowSize: const Size(400, 800),
        features: [cutout(bounds: const Rect.fromLTWH(180, 0, 40, 20))],
      );
      expect(info.hasDisplayFeature, isTrue);
      expect(info.hasHinge, isFalse);
      expect(info.isSeparating, isFalse);
    });
  });

  group('FoldableLayout', () {
    test('splits when both hinge regions fit', () {
      final info = FoldInfo.fromFeatures(
        windowSize: const Size(800, 600),
        features: [hinge(bounds: const Rect.fromLTWH(395, 0, 10, 600))],
      );
      expect(FoldableLayout.shouldUseTwoPanes(width: 800, info: info), isTrue);
    });

    test('single pane when a hinge region is too narrow', () {
      final info = FoldInfo.fromFeatures(
        windowSize: const Size(800, 600),
        features: [hinge(bounds: const Rect.fromLTWH(100, 0, 10, 600))],
      );
      expect(
        FoldableLayout.shouldUseTwoPanes(
          width: 800,
          info: info,
          minPaneWidth: 500,
        ),
        isFalse,
      );
    });

    test('falls back to width rule without hinges', () {
      const plain = FoldInfo.none();
      expect(
        FoldableLayout.shouldUseTwoPanes(width: 400, info: plain),
        isFalse,
      );
      expect(
        FoldableLayout.shouldUseTwoPanes(width: 1000, info: plain),
        isTrue,
      );
    });

    test('tabletop only for half-open horizontal hinges', () {
      const tabletop = FoldInfo(
        hasDisplayFeature: true,
        hasHinge: true,
        isFoldable: true,
        posture: FoldPosture.halfOpened,
        hingeAxis: Axis.horizontal,
        isSpanned: true,
        isSeparating: true,
      );
      expect(FoldableLayout.shouldUseTabletop(tabletop), isTrue);
      expect(FoldableLayout.shouldUseTabletop(const FoldInfo.none()), isFalse);
    });
  });
}
