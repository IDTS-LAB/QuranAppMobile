import 'package:flutter/material.dart';

/// Minimal placeholder for Task 11: search page.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search')),
    );
  }
}
