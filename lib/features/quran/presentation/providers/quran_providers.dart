import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/local/quran_local_data_source.dart';
import '../../data/datasources/remote/quran_remote_data_source.dart';
import '../../data/repositories/surah_repository_impl.dart';
import '../../domain/repositories/surah_repository.dart';
import '../../domain/use_cases/get_surah_detail.dart';
import '../../domain/use_cases/get_surahs.dart';
import '../../domain/use_cases/search_quran.dart';
import '../../domain/use_cases/toggle_bookmark.dart';
import '../controllers/bookmarks_controller.dart';
import '../controllers/quran_views.dart';
import '../controllers/surah_detail_controller.dart';
import '../controllers/surah_list_controller.dart';

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
