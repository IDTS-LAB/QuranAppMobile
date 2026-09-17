// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_dao.dart';

// ignore_for_file: type=lint
mixin _$QuranDaoMixin on DatabaseAccessor<AppDatabase> {
  $SurahRowsTable get surahRows => attachedDatabase.surahRows;
  $AyahRowsTable get ayahRows => attachedDatabase.ayahRows;
  $BookmarkRowsTable get bookmarkRows => attachedDatabase.bookmarkRows;
  $ReadingPositionRowsTable get readingPositionRows =>
      attachedDatabase.readingPositionRows;
  QuranDaoManager get managers => QuranDaoManager(this);
}

class QuranDaoManager {
  final _$QuranDaoMixin _db;
  QuranDaoManager(this._db);
  $$SurahRowsTableTableManager get surahRows =>
      $$SurahRowsTableTableManager(_db.attachedDatabase, _db.surahRows);
  $$AyahRowsTableTableManager get ayahRows =>
      $$AyahRowsTableTableManager(_db.attachedDatabase, _db.ayahRows);
  $$BookmarkRowsTableTableManager get bookmarkRows =>
      $$BookmarkRowsTableTableManager(_db.attachedDatabase, _db.bookmarkRows);
  $$ReadingPositionRowsTableTableManager get readingPositionRows =>
      $$ReadingPositionRowsTableTableManager(
        _db.attachedDatabase,
        _db.readingPositionRows,
      );
}
