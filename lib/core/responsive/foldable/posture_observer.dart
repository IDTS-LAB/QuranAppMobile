import 'package:flutter/widgets.dart';

import 'fold_info.dart';

/// Observes display-feature changes and rebuilds dependents.
///
/// Thin wrapper over [FoldInfo.fromContext]: `MediaQuery` already notifies
/// on display-feature changes, so this simply rebuilds [builder] with a
/// fresh snapshot. Use when a subtree must react to folding/unfolding
/// without depending on the ambient [FoldableDetector].
///
/// For most pages prefer [FoldableDetector] (single subscription) over
/// scattering observers.
class PostureObserver extends StatelessWidget {
  /// Creates an observer rebuilding [builder] on posture changes.
  const PostureObserver({super.key, required this.builder});

  /// Builds with the latest [FoldInfo].
  final Widget Function(BuildContext context, FoldInfo info) builder;

  @override
  Widget build(BuildContext context) {
    final info = FoldInfo.fromContext(context);
    return builder(context, info);
  }
}
