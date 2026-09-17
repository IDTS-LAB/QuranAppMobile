import 'package:flutter/material.dart';

/// Minimal placeholder for Task 11: surah detail page.
class SurahDetailPage extends StatelessWidget {
  const SurahDetailPage({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Surah $surahNumber')),
      body: Center(child: Text('Surah $surahNumber detail')),
    );
  }
}
