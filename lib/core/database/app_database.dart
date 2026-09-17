import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/quran_dao.dart';
import 'tables/quran_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [SurahRows, AyahRows, BookmarkRows, ReadingPositionRows],
  daos: [QuranDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'quran.db'));
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
