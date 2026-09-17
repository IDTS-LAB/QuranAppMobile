import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/responsive/adaptive_layout.dart';
import '../../../../core/widgets/empty/app_empty_view.dart';
import '../../../../core/widgets/error/app_error_view.dart';
import '../../../../core/widgets/loading/app_loading.dart';
import '../controllers/quran_views.dart';
import '../providers/quran_providers.dart';
import '../widgets/surah_card.dart';
import '../widgets/surah_detail_content.dart';

/// Surah list page: loading / error / empty / success over the surah list.
///
/// On expanded widths the list and the selected surah detail render
/// side-by-side; otherwise tapping a surah navigates to its detail route.
class SurahListPage extends ConsumerStatefulWidget {
  const SurahListPage({super.key});

  @override
  ConsumerState<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends ConsumerState<SurahListPage> {
  int? _selectedSurah;

  void _openSurah(int surahNumber) {
    setState(() {
      _selectedSurah = surahNumber;
    });
    context.go(RouteNames.surahDetail(surahNumber));
  }

  void _selectSurah(int surahNumber) {
    setState(() {
      _selectedSurah = surahNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<SurahView>> surahs = ref.watch(
      surahListControllerProvider,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Surahs')),
      body: switch (surahs) {
        AsyncLoading() => const AppLoading(),
        AsyncError(:final error) => AppErrorView.fromError(
          error: error,
          onRetry: () =>
              ref.read(surahListControllerProvider.notifier).refresh(),
        ),
        AsyncData(value: final list) => list.isEmpty
            ? const AppEmptyView(message: 'No surahs found')
            : AdaptiveLayout.builder(
                builder: (context, size) {
                  if (size == AdaptiveSize.expanded) {
                    final int selected =
                        _selectedSurah ?? list.first.number;
                    return Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: _SurahListView(
                            surahs: list,
                            selectedSurah: selected,
                            onTap: _selectSurah,
                            onRefresh: () => ref
                                .read(surahListControllerProvider.notifier)
                                .refresh(),
                          ),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          flex: 3,
                          child: SurahDetailContent(
                            key: ValueKey<int>(selected),
                            surahNumber: selected,
                          ),
                        ),
                      ],
                    );
                  }
                  return _SurahListView(
                    surahs: list,
                    selectedSurah: null,
                    onTap: _openSurah,
                    onRefresh: () => ref
                        .read(surahListControllerProvider.notifier)
                        .refresh(),
                  );
                },
              ),
      },
    );
  }
}

/// Scrollable surah list with pull-to-refresh.
class _SurahListView extends StatelessWidget {
  const _SurahListView({
    required this.surahs,
    required this.selectedSurah,
    required this.onTap,
    required this.onRefresh,
  });

  final List<SurahView> surahs;
  final int? selectedSurah;
  final ValueChanged<int> onTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final SurahView surah = surahs[index];
          return SurahCard(
            key: ValueKey<int>(surah.number),
            surah: surah,
            selected: surah.number == selectedSurah,
            onTap: () => onTap(surah.number),
          );
        },
      ),
    );
  }
}
