import 'package:drift/drift.dart';

class SurahRows extends Table {
  IntColumn get number => integer()();
  TextColumn get arabicName => text()();
  TextColumn get englishName => text()();
  TextColumn get englishMeaning => text()();
  TextColumn get revelationType => text()();
  IntColumn get ayahCount => integer()();

  @override
  Set<Column> get primaryKey => {number};
}

class AyahRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get numberInSurah => integer()();
  IntColumn get numberInQuran => integer().nullable()();
  TextColumn get arabicText => text()();
  TextColumn get translation => text().nullable()();
  IntColumn get juz => integer().nullable()();
  IntColumn get page => integer().nullable()();
}

class BookmarkRows extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {surahNumber, ayahNumber};
}

class ReadingPositionRows extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {surahNumber};
}
