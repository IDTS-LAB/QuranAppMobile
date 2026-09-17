import '../../../../core/errors/app_exception.dart';
import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../repositories/surah_repository.dart';

final class SearchQuran {
  SearchQuran(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Ayah>>> call(String query) {
    if (query.trim().length < 2) {
      return Future.value(
        const Result.failure(
          ValidationException('Type at least 2 characters'),
        ),
      );
    }
    return _repo.search(query.trim());
  }
}
