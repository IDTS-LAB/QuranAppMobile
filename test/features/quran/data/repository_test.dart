import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/data/datasources/local/quran_local_data_source.dart';
import 'package:quran_app/features/quran/data/datasources/remote/quran_remote_data_source.dart';
import 'package:quran_app/features/quran/data/repositories/surah_repository_impl.dart';

class _NoNetworkRemote implements QuranRemoteDataSource {
  @override
  Future<List<Map<String, Object?>>> fetchSurahs() =>
      throw Exception('offline');
  @override
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int n) =>
      throw Exception('offline');
}

void main() {
  test('repository returns local data when remote fails', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final local = QuranLocalDataSource(db.quranDao);
    await local.seedSurahs([
      {
        'number': 1,
        'arabicName': 'الفاتحة',
        'englishName': 'Al-Fatiha',
        'englishMeaning': 'The Opener',
        'revelationType': 'Meccan',
        'ayahCount': 7,
      },
    ]);
    final repo = SurahRepositoryImpl(remote: _NoNetworkRemote(), local: local);
    final res = await repo.getSurahs();
    expect(res.isSuccess, true);
    await db.close();
  });
}
