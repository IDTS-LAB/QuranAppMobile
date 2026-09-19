import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/features/settings/data/repositories/locale_repository_impl.dart';

void main() {
  late AppDatabase db;
  late LocaleRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = LocaleRepositoryImpl(db.settingsDao);
  });

  tearDown(() async => db.close());

  test('returns null when no locale was saved (system default)', () async {
    expect(await repository.getSavedLocale(), isNull);
  });

  test('round-trips a saved locale', () async {
    await repository.saveLocale(AppLocale.english);
    expect(await repository.getSavedLocale(), AppLocale.english);
  });

  test('clearing restores the system default', () async {
    await repository.saveLocale(AppLocale.english);
    await repository.saveLocale(null);
    expect(await repository.getSavedLocale(), isNull);
  });

  test('unknown stored codes resolve to null instead of crashing', () async {
    await db.settingsDao.setSetting('locale', 'xx-unknown');
    expect(await repository.getSavedLocale(), isNull);
  });
}
