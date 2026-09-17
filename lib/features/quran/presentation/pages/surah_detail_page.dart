import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/surah_detail_content.dart';

/// Detail page for a single surah.
///
/// Delegates rendering to [SurahDetailContent], which handles loading /
/// error / empty / success, bookmark toggles, resume banner, and reading
/// position persistence.
class SurahDetailPage extends ConsumerWidget {
  const SurahDetailPage({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Surah $surahNumber')),
      body: SurahDetailContent(surahNumber: surahNumber),
    );
  }
}
