import 'dart:ui' show Locale;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/features/settings/presentation/providers/settings_providers.dart';

/// Locale override state: a [Locale] when the user picked a language,
/// `null` to follow the system language.
final class LocaleController extends AsyncNotifier<Locale?> {
  @override
  Future<Locale?> build() async {
    final saved = await ref.watch(localeRepositoryProvider).getSavedLocale();
    return saved?.locale;
  }

  /// Persists [locale] (`null` clears the override) and updates state.
  Future<void> setLocale(AppLocale? locale) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(localeRepositoryProvider).saveLocale(locale);
      return locale?.locale;
    });
  }

  /// Clears the override so the app follows the system language.
  Future<void> useSystem() => setLocale(null);
}
