import '../../../../core/result/result.dart';
import '../entities/surah.dart';
import '../repositories/surah_repository.dart';

final class GetSurahs {
  GetSurahs(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Surah>>> call() => _repo.getSurahs();
}
