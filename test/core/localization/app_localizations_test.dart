import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/l10n/app_localizations.dart';

void main() {
  test('English strings resolve, including placeholders', () async {
    final AppLocalizations loc = await AppLocalizations.delegate.load(
      const Locale('en'),
    );

    expect(loc.appTitle, 'Quran');
    expect(loc.navHome, 'Home');
    expect(loc.surahsTitle, 'Surahs');
    expect(loc.surahTitle(18), 'Surah 18');
    expect(loc.ayahLabel(10), 'Ayah 10');
    expect(loc.bookmarkRow(2, 142), 'Surah 2 · Ayah 142');
    expect(loc.resumeTitle(2, 142), 'Resume Surah 2 · Ayah 142');
    expect(loc.surahListSubtitle('The Cave', 110), 'The Cave · 110 ayahs');
    expect(loc.retryButton, 'Retry');
    expect(loc.settingsSystemDefault, 'System default');
  });

  test('only English is supported for now', () {
    expect(AppLocalizations.supportedLocales.map((l) => l.languageCode), [
      'en',
    ]);
  });
}
