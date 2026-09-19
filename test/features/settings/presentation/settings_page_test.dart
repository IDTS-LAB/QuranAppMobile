import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/features/settings/domain/repositories/locale_repository.dart';
import 'package:quran_app/features/settings/presentation/pages/settings_page.dart';
import 'package:quran_app/features/settings/presentation/providers/settings_providers.dart';
import 'package:quran_app/l10n/app_localizations.dart';

class _FakeLocaleRepository implements LocaleRepository {
  AppLocale? stored;

  @override
  Future<AppLocale?> getSavedLocale() async => stored;

  @override
  Future<void> saveLocale(AppLocale? locale) async {
    stored = locale;
  }
}

Future<void> _pumpSettings(
  WidgetTester tester,
  _FakeLocaleRepository fake,
  Size size,
) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  return tester.pumpWidget(
    ProviderScope(
      overrides: [localeRepositoryProvider.overrideWithValue(fake)],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('lists system default + supported languages', (tester) async {
    await _pumpSettings(tester, _FakeLocaleRepository(), const Size(400, 800));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('LANGUAGE'), findsOneWidget);
    expect(find.text('System default'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('selecting a language persists the override', (tester) async {
    final fake = _FakeLocaleRepository();
    await _pumpSettings(tester, fake, const Size(400, 800));
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(fake.stored, AppLocale.english);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders at 320px without overflow', (tester) async {
    await _pumpSettings(tester, _FakeLocaleRepository(), const Size(320, 700));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
