import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';
import 'quran_views.dart';

final class SurahDetailController extends AsyncNotifier<SurahDetailView> {
  SurahDetailController(this._surahNumber);

  final int _surahNumber;

  @override
  Future<SurahDetailView> build() async {
    final ayahsResult = await ref.watch(getSurahDetailProvider).call(
      _surahNumber,
    );
    final surahsResult = await ref.watch(getSurahsProvider).call();
    return _combine(ayahsResult, surahsResult, _surahNumber);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ayahsResult = await ref.read(getSurahDetailProvider).call(
        _surahNumber,
      );
      final surahsResult = await ref.read(getSurahsProvider).call();
      return _combine(ayahsResult, surahsResult, _surahNumber);
    });
  }

  SurahDetailView _combine(
    Result<List<Ayah>> ayahsResult,
    Result<List<Surah>> surahsResult,
    int surahNumber,
  ) {
    final ayahs = switch (ayahsResult) {
      Success(value: final value) => value,
      Failure(error: final error) => throw error,
    };
    final surahs = switch (surahsResult) {
      Success(value: final value) => value,
      Failure(error: final error) => throw error,
    };
    for (final surah in surahs) {
      if (surah.number == surahNumber) {
        return SurahDetailView(surah: surah, ayahs: ayahs);
      }
    }
    throw NotFoundException('Surah $surahNumber not found');
  }
}
