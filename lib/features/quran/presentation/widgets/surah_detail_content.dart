import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/empty/app_empty_view.dart';
import '../../../../core/widgets/error/app_error_view.dart';
import '../../../../core/widgets/loading/app_loading.dart';
import '../../domain/entities/ayah.dart';
import '../controllers/quran_views.dart';
import '../providers/quran_providers.dart';
import 'ayah_tile.dart';
import 'resume_banner.dart';

/// Shared surah-detail body: watches the detail, bookmarks, and reading
/// position providers and renders loading / error / empty / success.
///
/// Persists the reading position for each visible ayah and offers a
/// [ResumeBanner] that scrolls back to the saved ayah. Used both by
/// [SurahDetailPage] and the expanded two-pane surah list.
class SurahDetailContent extends ConsumerStatefulWidget {
  const SurahDetailContent({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  ConsumerState<SurahDetailContent> createState() =>
      _SurahDetailContentState();
}

class _SurahDetailContentState extends ConsumerState<SurahDetailContent> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _ayahKeys = <int, GlobalKey>{};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  GlobalKey _keyFor(int ayahNumber) =>
      _ayahKeys.putIfAbsent(ayahNumber, GlobalKey.new);

  void _savePosition(Ayah ayah) {
    if (!mounted) {
      return;
    }
    unawaited(
      ref
          .read(surahRepositoryProvider)
          .saveReadingPosition(ayah.surahNumber, ayah.numberInSurah),
    );
  }

  void _scrollToAyah(int ayahNumber) {
    final BuildContext? target =
        _ayahKeys[ayahNumber]?.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<SurahDetailView> detail = ref.watch(
      surahDetailControllerProvider(widget.surahNumber),
    );
    return switch (detail) {
      AsyncLoading() => const AppLoading(),
      AsyncError(:final error) => AppErrorView.fromError(
        error: error,
        onRetry: () => ref
            .read(
              surahDetailControllerProvider(widget.surahNumber).notifier,
            )
            .refresh(),
      ),
      AsyncData(value: final view) => _DetailSuccess(
        view: view,
        scrollController: _scrollController,
        keyFor: _keyFor,
        onVisible: _savePosition,
        onResume: _scrollToAyah,
      ),
    };
  }
}

/// Success body for [SurahDetailContent].
class _DetailSuccess extends ConsumerWidget {
  const _DetailSuccess({
    required this.view,
    required this.scrollController,
    required this.keyFor,
    required this.onVisible,
    required this.onResume,
  });

  final SurahDetailView view;
  final ScrollController scrollController;
  final GlobalKey Function(int ayahNumber) keyFor;
  final ValueChanged<Ayah> onVisible;
  final ValueChanged<int> onResume;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (view.ayahs.isEmpty) {
      return const AppEmptyView(message: 'No ayahs found');
    }
    final AsyncValue<List<BookmarkView>> bookmarks = ref.watch(
      bookmarksControllerProvider,
    );
    final Set<String> bookmarked = switch (bookmarks) {
      AsyncData(value: final list) => <String>{
        for (final BookmarkView bookmark in list)
          '${bookmark.surahNumber}:${bookmark.ayahNumber}',
      },
      _ => <String>{},
    };
    final position = ref.watch(
      readingPositionProvider(view.surah.number),
    );
    return Column(
      children: <Widget>[
        position.when(
          data: (saved) => saved == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: ResumeBanner(
                    position: saved,
                    onTap: () => onResume(saved.ayahNumber),
                  ),
                ),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: view.ayahs.length,
            itemBuilder: (context, index) {
              final Ayah ayah = view.ayahs[index];
              final String key =
                  '${ayah.surahNumber}:${ayah.numberInSurah}';
              return Container(
                key: keyFor(ayah.numberInSurah),
                child: AyahTile(
                  ayah: ayah,
                  bookmarked: bookmarked.contains(key),
                  onBookmark: () => ref
                      .read(bookmarksControllerProvider.notifier)
                      .toggle(ayah.surahNumber, ayah.numberInSurah),
                  onVisible: onVisible,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
