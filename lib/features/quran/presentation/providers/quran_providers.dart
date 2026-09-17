import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/core/network/dio_client.dart';
import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/data/datasources/local/quran_local_data_source.dart';
import 'package:quran_app/features/quran/data/datasources/remote/quran_remote_data_source.dart';
import 'package:quran_app/features/quran/data/repositories/surah_repository_impl.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/reading_position.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';
import 'package:quran_app/features/quran/domain/use_cases/get_surah_detail.dart';
import 'package:quran_app/features/quran/domain/use_cases/get_surahs.dart';
import 'package:quran_app/features/quran/domain/use_cases/search_quran.dart';
import 'package:quran_app/features/quran/domain/use_cases/toggle_bookmark.dart';
import 'package:quran_app/features/quran/presentation/controllers/bookmarks_controller.dart';
import 'package:quran_app/features/quran/presentation/controllers/quran_views.dart';
import 'package:quran_app/features/quran/presentation/controllers/surah_detail_controller.dart';
import 'package:quran_app/features/quran/presentation/controllers/surah_list_controller.dart';

final dioProvider = Provider<Dio>((ref) => DioClient.create());

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final surahRepositoryProvider = Provider<SurahRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final database = ref.watch(databaseProvider);
  return SurahRepositoryImpl(
    remote: QuranRemoteDataSourceImpl(dio),
    local: QuranLocalDataSource(database.quranDao),
  );
});

final getSurahsProvider = Provider<GetSurahs>(
  (ref) => GetSurahs(ref.watch(surahRepositoryProvider)),
);

final getSurahDetailProvider = Provider<GetSurahDetail>(
  (ref) => GetSurahDetail(ref.watch(surahRepositoryProvider)),
);

final searchQuranProvider = Provider<SearchQuran>(
  (ref) => SearchQuran(ref.watch(surahRepositoryProvider)),
);

final toggleBookmarkProvider = Provider<ToggleBookmark>(
  (ref) => ToggleBookmark(ref.watch(surahRepositoryProvider)),
);

final surahListControllerProvider =
    AsyncNotifierProvider.autoDispose<SurahListController, List<SurahView>>(
      SurahListController.new,
      // Surface Result.failure as AsyncError immediately; the UI
      // triggers refresh explicitly instead of auto-retrying.
      retry: (_, _) => null,
    );

final surahDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SurahDetailController, SurahDetailView, int>(
      SurahDetailController.new,
      retry: (_, _) => null,
    );

final bookmarksControllerProvider =
    AsyncNotifierProvider.autoDispose<BookmarksController, List<BookmarkView>>(
      BookmarksController.new,
      retry: (_, _) => null,
    );

/// Search results for a validated [query] (2+ chars enforced by
/// [SearchQuran]). Failures surface as [AsyncError] for pages to render.
final searchResultsProvider =
    FutureProvider.autoDispose.family<List<Ayah>, String>((ref, query) async {
      final result = await ref.watch(searchQuranProvider).call(query);
      return switch (result) {
        Success(value: final ayahs) => ayahs,
        Failure(error: final error) => throw error,
      };
    });

/// Saved reading position for [surahNumber], or `null` when none exists
/// or loading fails (the resume banner simply stays hidden).
final readingPositionProvider =
    FutureProvider.autoDispose.family<ReadingPosition?, int>((
      ref,
      surahNumber,
    ) async {
      final result = await ref
          .watch(surahRepositoryProvider)
          .getReadingPosition(surahNumber);
      return switch (result) {
        Success(value: final position) => position,
        Failure() => null,
      };
    });
