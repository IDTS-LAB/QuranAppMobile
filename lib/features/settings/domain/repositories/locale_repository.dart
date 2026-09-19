import 'package:quran_app/core/localization/app_locale.dart';

/// Locale persistence contract.
///
/// `null` means "no override — follow the system language".
abstract interface class LocaleRepository {
  /// Reads the saved override, or `null` for system default.
  Future<AppLocale?> getSavedLocale();

  /// Persists [locale], or clears the override when `null`.
  Future<void> saveLocale(AppLocale? locale);
}
