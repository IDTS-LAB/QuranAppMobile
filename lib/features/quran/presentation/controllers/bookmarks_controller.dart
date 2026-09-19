import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';

import 'quran_views.dart';

final class BookmarksController extends AsyncNotifier<List<BookmarkView>> {
  @override
  Future<List<BookmarkView>> build() async {
    final result = await ref.watch(surahRepositoryProvider).getBookmarks();
    return switch (result) {
      Success(value: final bookmarks) => bookmarks,
      Failure(error: final error) => throw error,
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(surahRepositoryProvider).getBookmarks();
      return switch (result) {
        Success(value: final bookmarks) => bookmarks,
        Failure(error: final error) => throw error,
      };
    });
  }

  Future<void> toggle(int surahNumber, int ayahNumber) async {
    final result = await ref
        .read(toggleBookmarkProvider)
        .call(surahNumber, ayahNumber);
    if (result case Failure(error: final error)) {
      state = AsyncError(error, StackTrace.current);
      return;
    }
    await refresh();
  }
}
