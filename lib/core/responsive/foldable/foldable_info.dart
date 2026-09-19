// Backward-compatibility shim: prefer `fold_info.dart` ([FoldInfo]).
//
// Old imports of `foldable_info.dart` keep working. New code should use
// [FoldInfo] / [FoldPosture] from `fold_info.dart`.
library;

export 'fold_info.dart';

import 'package:flutter/material.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';

import 'fold_info.dart' as fi show FoldInfo, FoldPosture;

/// Legacy posture enum (use [FoldPosture] for new code).
@Deprecated('Use FoldPosture from fold_info.dart (adds flat/unknown).')
enum FoldablePosture { folded, halfOpen, fullyOpen, unknown }

/// Legacy display snapshot (use [FoldInfo] for new code).
@Deprecated('Use FoldInfo from fold_info.dart.')
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

  /// Inferred posture.
  final FoldablePosture posture;

  /// Bounds of the hinge/fold feature, if any.
  final Rect? hingeBounds;

  /// Reads display features from [MediaQuery] for [context].
  factory FoldableInfo.fromContext(BuildContext context) {
    final info = fi.FoldInfo.fromContext(context);
    return FoldableInfo(
      hasHinge: info.hasHinge,
      isDualScreen: info.isSpanned,
      hingeBounds: info.hingeBounds,
      posture: switch (info.posture) {
        fi.FoldPosture.folded => FoldablePosture.folded,
        fi.FoldPosture.halfOpened => FoldablePosture.halfOpen,
        fi.FoldPosture.fullyOpen => FoldablePosture.fullyOpen,
        fi.FoldPosture.flat => FoldablePosture.fullyOpen,
        fi.FoldPosture.unknown => FoldablePosture.unknown,
      },
    );
  }

  /// Whether a hinge/fold display feature intersects the window.
  bool get hasDisplayFeature => hasHinge;
}

/// Legacy width helper preserved for existing callers.
@Deprecated('Use Breakpoints.breakpointOf / AppBreakpoint instead.')
bool isFoldedCompact(double width) => width < Breakpoints.compactMaxWidth;
