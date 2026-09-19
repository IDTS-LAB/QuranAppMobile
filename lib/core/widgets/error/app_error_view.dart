import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';

/// Shared error view: message plus a retry button.
///
/// Use [AppErrorView.fromError] to render an [AsyncValue]-style error
/// without leaking infra details into pages.
///
/// Content is width-constrained (560dp) and scrollable so long messages +
/// large text-scaling cannot overflow narrow windows or short viewports.
class AppErrorView extends StatelessWidget {
  /// Creates an error view with an explicit [message].
  const AppErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon = Icons.error_outline,
  });

  /// Creates an error view from an caught [error] object.
  AppErrorView.fromError({
    super.key,
    required Object error,
    required this.onRetry,
    this.icon = Icons.error_outline,
  }) : message = _messageOf(error);

  /// Message to display.
  final String message;

  /// Retry handler.
  final VoidCallback onRetry;

  /// Leading icon override.
  final IconData icon;

  static String _messageOf(Object error) => error.toString();

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
                const SizedBox(height: AppSpacing.md),
                AppRetryButton(onRetry: onRetry),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shared retry button used by [AppErrorView].
class AppRetryButton extends StatelessWidget {
  /// Creates a retry button.
  const AppRetryButton({super.key, required this.onRetry});

  /// Retry handler.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onRetry, child: const Text('Retry'));
  }
}
