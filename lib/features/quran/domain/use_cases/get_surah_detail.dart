import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../repositories/surah_repository.dart';

final class GetSurahDetail {
  GetSurahDetail(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Ayah>>> call(int surahNumber) =>
      _repo.getSurahDetail(surahNumber);
}
