import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/empty/app_empty_view.dart';
import '../../../../core/widgets/error/app_error_view.dart';
import '../../../../core/widgets/layout/hinge_aware_two_pane.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/responsive/foldable/fold_info.dart';
import '../../../../core/responsive/foldable/foldable_layout.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/loading/app_loading.dart';
import '../controllers/quran_views.dart';
import '../providers/quran_providers.dart';
import '../widgets/surah_card.dart';
import '../widgets/surah_detail_content.dart';

/// Surah list page: loading / error / empty / success over the surah list.
///
/// On wide windows (or spanned foldables with two usable regions) the list
/// and the selected surah detail render side-by-side via [HingeAwareTwoPane];
/// otherwise tapping a surah navigates to its detail route.
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).surahsTitle)),
      body: switch (surahs) {
        AsyncLoading() => const AppLoading(),
        AsyncError(:final error) => AppErrorView.fromError(
          error: error,
          onRetry: () =>
              ref.read(surahListControllerProvider.notifier).refresh(),
        ),
        AsyncData(value: final list) =>
          list.isEmpty
              ? AppEmptyView(message: AppLocalizations.of(context).surahsEmpty)
              : _ResponsiveBody(
                  surahs: list,
                  selectedSurah: _selectedSurah,
                  onSelect: _selectSurah,
                  onOpen: _openSurah,
                  onRefresh: () =>
                      ref.read(surahListControllerProvider.notifier).refresh(),
                ),
      },
    );
  }
}

/// Width/fold-aware body: two-pane when regions allow, else navigating list.
class _ResponsiveBody extends StatelessWidget {
  const _ResponsiveBody({
    required this.surahs,
    required this.selectedSurah,
    required this.onSelect,
    required this.onOpen,
    required this.onRefresh,
  });

  final List<SurahView> surahs;
  final int? selectedSurah;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onOpen;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final int selected = selectedSurah ?? surahs.first.number;
    // Single-pane taps navigate to the detail route; two-pane taps select
    // inline. The decision mirrors HingeAwareTwoPane's rule so the callback
    // always matches the rendered layout.
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoPane = FoldableLayout.shouldUseTwoPanes(
          width: constraints.maxWidth,
          info: FoldInfo.fromContext(context),
          splitRatio: 0.4,
          minPaneWidth: 320,
          minBreakpoint: AppBreakpoint.expanded,
        );
        return HingeAwareTwoPane(
          splitRatio: 0.4,
          minPaneWidth: 320,
          first: _SurahListView(
            surahs: surahs,
            selectedSurah: twoPane ? selected : null,
            onTap: twoPane ? onSelect : onOpen,
            onRefresh: onRefresh,
          ),
          second: SurahDetailContent(
            key: ValueKey<int>(selected),
            surahNumber: selected,
          ),
        );
      },
    );
  }
}

/// Scrollable surah list with pull-to-refresh.
///
/// In single-pane mode [selectedSurah] is null and taps navigate ([onOpen]
/// passed as [onTap] by the caller); in two-pane mode taps select inline.
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
