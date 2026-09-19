import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:quran_app/features/settings/presentation/providers/settings_providers.dart';
import 'package:quran_app/l10n/app_localizations.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Riverpod-provided router instance.
final routerProvider = Provider<GoRouter>((ref) => AppRouter.create());

/// Application root: Material 3 light/dark themes driven by [AppTheme],
/// navigation driven by the shared [routerProvider], locale driven by
/// [localeControllerProvider] (`null` follows the system language).
class QuranApp extends ConsumerWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    final locale = switch (ref.watch(localeControllerProvider)) {
      AsyncData(value: final override) => override,
      _ => null,
    };
    return MaterialApp.router(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
