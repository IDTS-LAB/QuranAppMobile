import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';
import 'quran_views.dart';

final class SurahListController extends AsyncNotifier<List<SurahView>> {
  @override
  Future<List<SurahView>> build() async {
    final result = await ref.watch(getSurahsProvider).call();
    return switch (result) {
      Success(value: final surahs) => surahs,
      Failure(error: final error) => throw error,
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(getSurahsProvider).call();
      return switch (result) {
        Success(value: final surahs) => surahs,
        Failure(error: final error) => throw error,
      };
    });
  }
}
