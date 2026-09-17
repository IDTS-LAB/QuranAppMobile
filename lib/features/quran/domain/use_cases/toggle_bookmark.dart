import '../../../../core/result/result.dart';
import '../repositories/surah_repository.dart';

final class ToggleBookmark {
  ToggleBookmark(this._repo);
  final SurahRepository _repo;
  Future<Result<void>> call(int surah, int ayah) =>
      _repo.toggleBookmark(surah, ayah);
}
