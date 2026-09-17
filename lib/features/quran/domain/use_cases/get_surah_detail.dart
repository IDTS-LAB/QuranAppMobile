import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';

final class GetSurahDetail {
  GetSurahDetail(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Ayah>>> call(int surahNumber) =>
      _repo.getSurahDetail(surahNumber);
}
