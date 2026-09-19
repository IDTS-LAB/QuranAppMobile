import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/features/settings/domain/repositories/locale_repository.dart';
import 'package:quran_app/features/settings/presentation/providers/settings_providers.dart';

class _FakeLocaleRepository implements LocaleRepository {
  AppLocale? stored;

  @override
  Future<AppLocale?> getSavedLocale() async => stored;

  @override
  Future<void> saveLocale(AppLocale? locale) async {
    stored = locale;
  }
}

void main() {
  test('starts with the system default and restores a saved locale', () async {
    final fake = _FakeLocaleRepository()..stored = AppLocale.english;
    final container = ProviderContainer(
      overrides: [localeRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);

    expect(await container.read(localeControllerProvider.future), isNotNull);
    expect(container.read(localeControllerProvider).value?.languageCode, 'en');
  });

  test('empty storage resolves to null (system default)', () async {
    final container = ProviderContainer(
      overrides: [
        localeRepositoryProvider.overrideWithValue(_FakeLocaleRepository()),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(localeControllerProvider.future), isNull);
  });

  test('setLocale persists and updates state', () async {
    final fake = _FakeLocaleRepository();
    final container = ProviderContainer(
      overrides: [localeRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    await container.read(localeControllerProvider.future);

    await container
        .read(localeControllerProvider.notifier)
        .setLocale(AppLocale.english);

    expect(fake.stored, AppLocale.english);
    expect(container.read(localeControllerProvider).value?.languageCode, 'en');
  });

  test('useSystem clears the override', () async {
    final fake = _FakeLocaleRepository()..stored = AppLocale.english;
    final container = ProviderContainer(
      overrides: [localeRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    await container.read(localeControllerProvider.future);

    await container.read(localeControllerProvider.notifier).useSystem();

    expect(fake.stored, isNull);
    expect(container.read(localeControllerProvider).value, isNull);
  });
}
