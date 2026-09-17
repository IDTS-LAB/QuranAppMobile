import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/bookmark.dart';
import 'package:quran_app/features/quran/domain/entities/reading_position.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

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
