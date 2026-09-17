import 'package:flutter/material.dart';

import 'package:quran_app/features/quran/domain/entities/reading_position.dart';

/// Banner that resumes reading at a saved [position].
///
/// Pure presentation: renders the [position] entity and forwards taps via
/// [onTap]. No data access or business logic inside.
class ResumeBanner extends StatelessWidget {
  const ResumeBanner({
    super.key,
    required this.position,
    required this.onTap,
  });

  final ReadingPosition position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.history),
        title: Text(
          'Resume Surah ${position.surahNumber} · '
          'Ayah ${position.ayahNumber}',
        ),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
