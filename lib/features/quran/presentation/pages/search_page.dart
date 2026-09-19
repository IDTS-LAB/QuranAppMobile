import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/empty/app_empty_view.dart';
import '../../../../core/widgets/error/app_error_view.dart';
import '../../../../core/widgets/layout/responsive_container.dart';
import '../../../../core/widgets/loading/app_loading.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/ayah.dart';
import '../controllers/quran_views.dart';
import '../providers/quran_providers.dart';
import '../widgets/ayah_tile.dart';

/// Search page: debounced (300ms) search requiring 2+ characters.
///
/// Short or empty queries render hint states instead of hitting the
/// repository; validated queries render loading / error / empty / success.
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  /// Debounce before a query is submitted.
  static const Duration debounce = Duration(milliseconds: 300);

  /// Minimum query length accepted by [SearchQuran].
  static const int minQueryLength = 2;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(SearchPage.debounce, () {
      if (!mounted) {
        return;
      }
      setState(() {
        _query = value.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.searchTitle)),
      body: ResponsiveContainer(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                decoration: InputDecoration(
                  hintText: localizations.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(child: _SearchResults(query: _query)),
          ],
        ),
      ),
    );
  }
}

/// Results body for [_SearchPageState].
class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    if (query.isEmpty) {
      return AppEmptyView(message: localizations.searchHint);
    }
    if (query.length < SearchPage.minQueryLength) {
      return AppEmptyView(message: localizations.searchTooShort);
    }
    final AsyncValue<List<Ayah>> results = ref.watch(
      searchResultsProvider(query),
    );
    return switch (results) {
      AsyncLoading() => const AppLoading(),
      AsyncError(:final error) => AppErrorView.fromError(
        error: error,
        onRetry: () => ref.invalidate(searchResultsProvider(query)),
      ),
      AsyncData(value: final ayahs) =>
        ayahs.isEmpty
            ? AppEmptyView(message: localizations.searchNoResults)
            : _ResultsList(query: query, ayahs: ayahs),
    };
  }
}

/// Scrollable search results with bookmark toggles.
class _ResultsList extends ConsumerWidget {
  const _ResultsList({required this.query, required this.ayahs});

  final String query;
  final List<Ayah> ayahs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return ListView.builder(
      itemCount: ayahs.length,
      itemBuilder: (context, index) {
        final Ayah ayah = ayahs[index];
        final String key = '${ayah.surahNumber}:${ayah.numberInSurah}';
        return AyahTile(
          key: ValueKey<String>(key),
          ayah: ayah,
          bookmarked: bookmarked.contains(key),
          onBookmark: () => ref
              .read(bookmarksControllerProvider.notifier)
              .toggle(ayah.surahNumber, ayah.numberInSurah),
        );
      },
    );
  }
}
