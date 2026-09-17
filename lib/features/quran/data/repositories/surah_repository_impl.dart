import 'package:dio/dio.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/interceptors/error_interceptor.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/entities/reading_position.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/surah_repository.dart';
import '../datasources/local/quran_local_data_source.dart';
import '../datasources/remote/quran_remote_data_source.dart';
import '../dto/ayah_dto.dart';
import '../dto/surah_dto.dart';
import '../mappers/ayah_mapper.dart';
import '../mappers/surah_mapper.dart';

final class SurahRepositoryImpl implements SurahRepository {
  SurahRepositoryImpl({required this.remote, required this.local});
  final QuranRemoteDataSource remote;
  final QuranLocalDataSource local;

  @override
  Future<Result<List<Surah>>> getSurahs() async {
    try {
      final cached = await local.getSurahs();
      if (cached.isNotEmpty) {
        _refreshSurahsInBackground();
        return Result.success(cached.map(surahRowToEntity).toList());
      }
      await syncFromRemote();
      final rows = await local.getSurahs();
      return Result.success(rows.map(surahRowToEntity).toList());
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  Future<void> _refreshSurahsInBackground() async {
    try {
      await syncFromRemote();
    } catch (_) {}
  }

  @override
  Future<Result<void>> syncFromRemote() async {
    try {
      final json = await remote.fetchSurahs();
      await local.seedSurahs(
        json.map((item) {
          final dto = SurahDto.fromJson(item);
          final entity = dto.toEntity();
          return <String, Object?>{
            'number': entity.number,
            'arabicName': entity.arabicName,
            'englishName': entity.englishName,
            'englishMeaning': entity.englishMeaning,
            'revelationType': entity.revelationType,
            'ayahCount': entity.ayahCount,
          };
        }).toList(),
      );
      return const Result.success(null);
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<List<Ayah>>> getSurahDetail(int surahNumber) async {
    try {
      final cached = await local.getAyahs(surahNumber);
      if (cached.isNotEmpty) {
        return Result.success(cached.map(ayahRowToEntity).toList());
      }
      final json = await remote.fetchSurahAyahs(surahNumber);
      final ayahs = json
          .map(
            (item) => AyahDto.fromJson(<String, Object?>{
              'number': item['number'] ?? 0,
              'text': (item['text'] ?? '') as String,
              'numberInSurah': item['numberInSurah'] ?? 0,
            }).toEntity(surahNumber: surahNumber),
          )
          .toList();
      // V1: return remote-mapped ayahs directly; bulk-persist to Drift is a
      // follow-up (local search covers seeded/short surahs).
      // Do not block UI on persist.
      return Result.success(ayahs);
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<List<Ayah>>> search(String query) async {
    try {
      final rows = await local.search(query);
      return Result.success(rows.map(ayahRowToEntity).toList());
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<List<Bookmark>>> getBookmarks() async {
    try {
      final rows = await local.getBookmarks();
      return Result.success(
        rows
            .map(
              (row) => Bookmark(
                surahNumber: row.surahNumber,
                ayahNumber: row.ayahNumber,
                createdAt: row.createdAt,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<void>> toggleBookmark(int surahNumber, int ayahNumber) async {
    try {
      await local.toggleBookmark(surahNumber, ayahNumber);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<void>> saveReadingPosition(
    int surahNumber,
    int ayahNumber,
  ) async {
    try {
      await local.saveReadingPosition(surahNumber, ayahNumber);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }

  @override
  Future<Result<ReadingPosition?>> getReadingPosition(int surahNumber) async {
    try {
      final row = await local.getReadingPosition(surahNumber);
      if (row == null) {
        return const Result.success(null);
      }
      return Result.success(
        ReadingPosition(
          surahNumber: row.surahNumber,
          ayahNumber: row.ayahNumber,
          updatedAt: row.updatedAt,
        ),
      );
    } catch (e) {
      return Result.failure(_mapError(e));
    }
  }
}

AppException _mapError(Object e) {
  if (e is DioException) {
    final inner = e.error;
    if (inner is AppException) {
      return inner;
    }
    return mapDioError(e);
  }
  if (e is AppException) {
    return e;
  }
  return UnknownException(e.toString());
}
