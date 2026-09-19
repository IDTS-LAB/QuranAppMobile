import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_spacing.dart';

/// Shared loading indicator: centered progress spinner.
///
/// Optional [label] renders helper text under the spinner (e.g. what is
/// loading); [semanticsLabel] is exposed to screen readers. Long labels
/// wrap within a width-constrained column so large text-scaling cannot
/// overflow narrow windows.
class AppLoading extends StatelessWidget {
  /// Creates a loading indicator.
  const AppLoading({super.key, this.label, this.semanticsLabel});

  /// Optional helper text under the spinner.
  final String? label;

  /// Screen-reader label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: semanticsLabel ?? label,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircularProgressIndicator(),
                if (label != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  // Excluded: the node label already carries this text.
                  ExcludeSemantics(
                    child: Text(label!, textAlign: TextAlign.center),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
