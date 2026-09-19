import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/quran_dao.dart';
import 'daos/settings_dao.dart';
import 'tables/quran_tables.dart';
import 'tables/settings_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [SurahRows, AyahRows, BookmarkRows, ReadingPositionRows, SettingRows],
  daos: [QuranDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'quran.db'));
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      // v1 → v2: locale/settings storage.
      if (from < 2) {
        await migrator.createTable(settingRows);
      }
    },
  );
}
