import 'package:flutter/material.dart';

/// Minimal placeholder for Task 11: surah list page.
class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Surahs')),
      body: const Center(child: Text('Surah list')),
    );
  }
}
