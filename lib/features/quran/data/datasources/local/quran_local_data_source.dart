import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/core/database/daos/quran_dao.dart';

final class QuranLocalDataSource {
  QuranLocalDataSource(this._dao);
  final QuranDao _dao;

  Future<List<SurahRow>> getSurahs() => _dao.getSurahs();

  Future<List<AyahRow>> getAyahs(int surahNumber) => _dao.getAyahs(surahNumber);

  Future<List<AyahRow>> search(String query) => _dao.searchAyahs(query);

  Future<List<BookmarkRow>> getBookmarks() => _dao.getBookmarks();

  Future<void> toggleBookmark(int surahNumber, int ayahNumber) =>
      _dao.toggleBookmark(surahNumber, ayahNumber);

  Future<void> saveReadingPosition(int surahNumber, int ayahNumber) =>
      _dao.saveReadingPosition(surahNumber, ayahNumber);

  Future<ReadingPositionRow?> getReadingPosition(int surahNumber) =>
      _dao.getReadingPosition(surahNumber);

  Future<void> seedSurahs(List<Map<String, Object?>> rows) async {
    for (final row in rows) {
      await _dao.upsertSurah(
        number: row['number'] as int,
        arabicName: row['arabicName'] as String,
        englishName: row['englishName'] as String,
        englishMeaning: row['englishMeaning'] as String,
        revelationType: row['revelationType'] as String,
        ayahCount: row['ayahCount'] as int,
      );
    }
  }
}
