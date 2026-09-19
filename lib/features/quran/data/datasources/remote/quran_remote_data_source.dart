import 'package:dio/dio.dart';

import 'package:quran_app/core/constants/app_constants.dart';

abstract interface class QuranRemoteDataSource {
  Future<List<Map<String, Object?>>> fetchSurahs();
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int surahNumber);
}

final class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  QuranRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<Map<String, Object?>>> fetchSurahs() async {
    final res = await _dio.get('/surah');
    final data = res.data as Map<String, Object?>;
    return (data['data'] as List).cast<Map<String, Object?>>();
  }

  @override
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int surahNumber) async {
    final res = await _dio.get(
      '/surah/$surahNumber/${AppConstants.translationEdition}',
    );
    final data =
        (res.data as Map<String, Object?>)['data'] as Map<String, Object?>;
    return (data['ayahs'] as List).cast<Map<String, Object?>>();
  }
}
