import 'package:flutter/widgets.dart';

import 'package:quran_app/l10n/app_localizations.dart';

/// Application language.
///
/// Designed for extension: adding a language means adding an enum value,
/// its `app_<code>.arb` file, and its display-name branch below. The
/// locale controller treats `null` (no saved override) as "follow system".
enum AppLocale {
  /// English (default template locale).
  english('en');

  /// Creates a locale entry from its BCP-47 [languageCode].
  const AppLocale(this.languageCode);

  /// BCP-47 language code persisted in settings.
  final String languageCode;

  /// Flutter [Locale] for MaterialApp and delegates.
  Locale get locale => Locale(languageCode);

  /// Localized display name for settings UI.
  String displayName(AppLocalizations localizations) {
    switch (this) {
      case AppLocale.english:
        return localizations.languageNameEnglish;
    }
  }

  /// Parses a persisted code; unknown codes yield `null` (system default)
  /// so corrupt/removed locales never crash startup.
  static AppLocale? fromLanguageCode(String? code) {
    if (code == null) return null;
    for (final value in AppLocale.values) {
      if (value.languageCode == code) return value;
    }
    return null;
  }
}
