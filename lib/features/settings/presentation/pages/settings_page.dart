import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/core/widgets/layout/responsive_container.dart';
import 'package:quran_app/core/widgets/typography/app_section_label.dart';
import 'package:quran_app/features/settings/presentation/providers/settings_providers.dart';
import 'package:quran_app/l10n/app_localizations.dart';

/// Settings page: application preferences.
///
/// Hosts the language switcher. The override applies immediately and is
/// persisted in Drift; "System default" clears it so the app follows the
/// device language.
class SettingsPage extends ConsumerWidget {
  /// Creates the settings page.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    final localeOverride = switch (ref.watch(localeControllerProvider)) {
      AsyncData(value: final locale) => locale,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settingsTitle)),
      body: ResponsiveContainer(
        child: ListView(
          children: <Widget>[
            AppSectionLabel(localizations.settingsLanguage),
            const SizedBox(height: AppSpacing.sm),
            Text(
              localizations.settingsLanguageSubtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            RadioGroup<String?>(
              groupValue: localeOverride?.languageCode,
              onChanged: (code) => ref
                  .read(localeControllerProvider.notifier)
                  .setLocale(AppLocale.fromLanguageCode(code)),
              child: Column(
                children: <Widget>[
                  RadioListTile<String?>(
                    title: Text(localizations.settingsSystemDefault),
                    value: null,
                  ),
                  for (final appLocale in AppLocale.values)
                    RadioListTile<String?>(
                      title: Text(appLocale.displayName(localizations)),
                      value: appLocale.languageCode,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
