import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';

/// Shared empty-state view: icon plus message.
///
/// Content is width-constrained (560dp) and scrollable so long messages +
/// large text-scaling cannot overflow narrow windows or short viewports.
class AppEmptyView extends StatelessWidget {
  /// Creates an empty-state view.
  const AppEmptyView({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  /// Message to display.
  final String message;

  /// Leading icon override.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon),
                const SizedBox(height: AppSpacing.sm),
                Text(message, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
