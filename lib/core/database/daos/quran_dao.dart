import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/quran_tables.dart';

part 'quran_dao.g.dart';

@DriftAccessor(
  tables: [SurahRows, AyahRows, BookmarkRows, ReadingPositionRows],
)
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);

  Future<List<SurahRow>> getSurahs() =>
      (select(surahRows)..orderBy([(t) => OrderingTerm.asc(t.number)])).get();

  Future<void> upsertSurah({
    required int number,
    required String arabicName,
    required String englishName,
    required String englishMeaning,
    required String revelationType,
    required int ayahCount,
  }) => into(surahRows).insertOnConflictUpdate(
    SurahRowsCompanion(
      number: Value(number),
      arabicName: Value(arabicName),
      englishName: Value(englishName),
      englishMeaning: Value(englishMeaning),
      revelationType: Value(revelationType),
      ayahCount: Value(ayahCount),
    ),
  );

  Future<List<AyahRow>> getAyahs(int surah) =>
      (select(ayahRows)
            ..where((t) => t.surahNumber.equals(surah))
            ..orderBy([(t) => OrderingTerm.asc(t.numberInSurah)]))
          .get();

  Future<List<AyahRow>> searchAyahs(String q) {
    final like = '%$q%';
    return (select(ayahRows)..where(
          (t) => t.arabicText.like(like) | t.translation.like(like),
        ))
        .get();
  }

  Future<List<BookmarkRow>> getBookmarks() => select(bookmarkRows).get();

  Future<void> toggleBookmark(int surah, int ayah) async {
    final existing =
        await (select(bookmarkRows)..where(
              (t) => t.surahNumber.equals(surah) & t.ayahNumber.equals(ayah),
            ))
            .getSingleOrNull();
    if (existing == null) {
      await into(bookmarkRows).insert(
        BookmarkRowsCompanion(
          surahNumber: Value(surah),
          ayahNumber: Value(ayah),
          createdAt: Value(DateTime.now()),
        ),
      );
    } else {
      await (delete(bookmarkRows)..where(
            (t) => t.surahNumber.equals(surah) & t.ayahNumber.equals(ayah),
          ))
          .go();
    }
  }

  Future<void> saveReadingPosition(int surah, int ayah) =>
      into(readingPositionRows).insertOnConflictUpdate(
        ReadingPositionRowsCompanion(
          surahNumber: Value(surah),
          ayahNumber: Value(ayah),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<ReadingPositionRow?> getReadingPosition(int surah) =>
      (select(readingPositionRows)
        ..where((t) => t.surahNumber.equals(surah))).getSingleOrNull();
}
