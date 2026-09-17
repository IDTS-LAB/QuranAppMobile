import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';
import 'package:quran_app/features/quran/domain/use_cases/get_surahs.dart';

class _FakeRepo implements SurahRepository {
  @override
  Future<Result<List<Surah>>> getSurahs() async => const Result.success([
    Surah(number: 1, arabicName: 'الفاتحة', englishName: 'Al-Fatiha',
      englishMeaning: 'The Opener', revelationType: 'Meccan', ayahCount: 7),
  ]);
  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

void main() {
  test('GetSurahs returns repository data', () async {
    final res = await GetSurahs(_FakeRepo()).call();
    expect(res.isSuccess, true);
  });
}
