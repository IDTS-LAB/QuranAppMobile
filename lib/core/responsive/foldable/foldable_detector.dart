import 'package:flutter/widgets.dart';

import 'fold_info.dart';

/// Inherited snapshot of the current foldable/window configuration.
///
/// Place once near the top of the tree (page/scaffold level) so descendants
/// read [FoldInfo] without re-subscribing to [MediaQuery] individually:
///
/// ```dart
/// FoldableDetector(
///   child: MyPage(),
/// );
/// ```
class FoldableDetector extends StatelessWidget {
  /// Creates a detector that publishes [FoldInfo] to descendants.
  const FoldableDetector({super.key, required this.child});

  /// Subtree that can read [FoldableScope] / [FoldableDetector.of].
  final Widget child;

  /// Reads the nearest scope, computing from [MediaQuery] when absent.
  static FoldInfo of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_FoldableScope>();
    if (scope != null) return scope.info;
    return FoldInfo.fromContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final info = FoldInfo.fromContext(context);
    return _FoldableScope(info: info, child: child);
  }
}

class _FoldableScope extends InheritedWidget {
  const _FoldableScope({required this.info, required super.child});

  final FoldInfo info;

  @override
  bool updateShouldNotify(_FoldableScope oldWidget) {
    return info.hasHinge != oldWidget.info.hasHinge ||
        info.isSpanned != oldWidget.info.isSpanned ||
        info.isSeparating != oldWidget.info.isSeparating ||
        info.posture != oldWidget.info.posture ||
        info.hingeBounds != oldWidget.info.hingeBounds;
  }
}
