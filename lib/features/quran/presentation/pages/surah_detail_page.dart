import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/core/widgets/layout/fold_aware_layout.dart';
import 'package:quran_app/core/widgets/layout/responsive_container.dart';
import 'package:quran_app/l10n/app_localizations.dart';

import '../widgets/surah_detail_content.dart';

/// Detail page for a single surah.
///
/// Delegates rendering to [SurahDetailContent], which handles loading /
/// error / empty / success, bookmark toggles, resume banner, and reading
/// position persistence. Content width is constrained on wide windows and
/// kept clear of hinge regions on foldables.
class SurahDetailPage extends ConsumerWidget {
  /// Creates the detail page for [surahNumber].
  const SurahDetailPage({super.key, required this.surahNumber});

  /// 1-based surah number.
  final int surahNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).surahTitle(surahNumber)),
      ),
      body: ResponsiveContainer(
        child: FoldAwareLayout(
          respectSafeAreas: false,
          child: SurahDetailContent(surahNumber: surahNumber),
        ),
      ),
    );
  }
}
