import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/widgets/empty/app_empty_view.dart';
import 'package:quran_app/core/widgets/error/app_error_view.dart';
import 'package:quran_app/core/widgets/layout/responsive_container.dart';
import 'package:quran_app/core/widgets/loading/app_loading.dart';
import 'package:quran_app/features/quran/presentation/controllers/quran_views.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';

/// Bookmarks page: loading / error / empty / success over saved bookmarks.
///
/// Each row removes its bookmark via the bookmarks controller.
class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<BookmarkView>> bookmarks = ref.watch(
      bookmarksControllerProvider,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: ResponsiveContainer(
        fullWidth: true,
        child: switch (bookmarks) {
          AsyncLoading() => const AppLoading(),
          AsyncError(:final error) => AppErrorView.fromError(
            error: error,
            onRetry: () =>
                ref.read(bookmarksControllerProvider.notifier).refresh(),
          ),
          AsyncData(value: final list) =>
            list.isEmpty
                ? const AppEmptyView(message: 'No bookmarks yet')
                : RefreshIndicator(
                    onRefresh: () => ref
                        .read(bookmarksControllerProvider.notifier)
                        .refresh(),
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final BookmarkView bookmark = list[index];
                        return ListTile(
                          key: ValueKey<String>(
                            '${bookmark.surahNumber}:${bookmark.ayahNumber}',
                          ),
                          leading: const Icon(Icons.bookmark),
                          title: Text(
                            'Surah ${bookmark.surahNumber} · '
                            'Ayah ${bookmark.ayahNumber}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            tooltip: 'Remove bookmark',
                            onPressed: () => ref
                                .read(bookmarksControllerProvider.notifier)
                                .toggle(
                                  bookmark.surahNumber,
                                  bookmark.ayahNumber,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
        },
      ),
    );
  }
}
