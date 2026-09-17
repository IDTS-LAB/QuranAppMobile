import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';

/// Shared error view: message plus a retry button.
///
/// Use [AppErrorView.fromError] to render an [AsyncValue]-style error
/// without leaking infra details into pages.
class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, required this.message, required this.onRetry});

  AppErrorView.fromError({
    super.key,
    required Object error,
    required this.onRetry,
  }) : message = _messageOf(error);

  final String message;
  final VoidCallback onRetry;

  static String _messageOf(Object error) => error.toString();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.error_outline),
            const SizedBox(height: AppSpacing.sm),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            AppRetryButton(onRetry: onRetry),
          ],
        ),
      ),
    );
  }
}

/// Shared retry button used by [AppErrorView].
class AppRetryButton extends StatelessWidget {
  const AppRetryButton({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onRetry, child: const Text('Retry'));
  }
}
