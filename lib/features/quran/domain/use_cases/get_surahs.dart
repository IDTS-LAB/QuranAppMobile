import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';

final class GetSurahs {
  GetSurahs(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Surah>>> call() => _repo.getSurahs();
}
