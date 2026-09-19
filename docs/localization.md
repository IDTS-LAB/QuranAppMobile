# Localization

English-first internationalization. All user-facing strings live in ARB
files; no hardcoded UI text in widgets or pages.

## Adding a language (e.g. Arabic)

1. Copy `lib/l10n/app_en.arb` → `lib/l10n/app_ar.arb`, set `"@@locale": "ar"`,
   translate every value (keep `{placeholders}` intact).
2. Add the enum value + display-name branch in
   `lib/core/localization/app_locale.dart`:
   ```dart
   arabic('ar');
   // displayName: return localizations.languageNameArabic;
   ```
   Add `languageNameArabic` to both ARB files first.
3. Run `flutter gen-l10n` (output: `lib/l10n/`, committed).
4. Add widget tests pumping the new locale; verify RTL (mirroring is
   automatic via `localizationsDelegates`; audit any remaining
   `EdgeInsets.only(left/right)` → use `Directional` variants).
5. `flutter analyze && flutter test`.

## Architecture

```text
lib/l10n/app_en.arb ──gen-l10n──▶ lib/l10n/app_localizations*.dart (committed)
lib/core/localization/app_locale.dart        AppLocale enum (persisted code)
lib/core/database/tables/settings_tables.dart  SettingRows + SettingsDao
lib/features/settings/
  domain/repositories/locale_repository.dart   get/save override (null = system)
  data/repositories/locale_repository_impl.dart
  presentation/controllers/locale_controller.dart  AsyncNotifier<Locale?>
  presentation/providers/settings_providers.dart
  presentation/pages/settings_page.dart          /more route (5th shell branch)
```

- `QuranApp` wires `locale` (override or system), `localizationsDelegates`,
  `supportedLocales`, and `onGenerateTitle`.
- The override applies immediately (whole `MaterialApp` rebuilds) and
  survives restarts via Drift (`SettingRows`, schema v2 migration).
- Usage: `AppLocalizations.of(context).surahTitle(18)`.

## Conventions

- Placeholders for interpolated values (`surahTitle`, `bookmarkRow`); never
  concatenate translated fragments.
- `@key` descriptions in ARB files are translator context — keep them.
- Screen-reader labels are user-facing: localize them too.
- Demo content (`homeDate`, progress/goal/recent placeholders, "Ahmed Razak")
  is keyed in English and will be replaced by real data/formatting
  (`intl` date symbols, Hijri calendar) in a follow-up.
