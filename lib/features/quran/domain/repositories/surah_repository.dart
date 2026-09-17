import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../entities/bookmark.dart';
import '../entities/reading_position.dart';
import '../entities/surah.dart';

abstract interface class SurahRepository {
  Future<Result<List<Surah>>> getSurahs();
  Future<Result<List<Ayah>>> getSurahDetail(int surahNumber);
  Future<Result<List<Ayah>>> search(String query);
  Future<Result<List<Bookmark>>> getBookmarks();
  Future<Result<void>> toggleBookmark(int surahNumber, int ayahNumber);
  Future<Result<void>> saveReadingPosition(int surahNumber, int ayahNumber);
  Future<Result<ReadingPosition?>> getReadingPosition(int surahNumber);
  Future<Result<void>> syncFromRemote();
}
