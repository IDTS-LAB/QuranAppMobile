import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/features/quran/domain/entities/reading_position.dart';

/// Banner that resumes reading at a saved [position].
///
/// Pure presentation: renders the [position] entity and forwards taps via
/// [onTap]. No data access or business logic inside.
///
/// Uses [AppCard] (theme-aware, responsive by default) instead of a raw
/// Material card so styling stays consistent with the design system.
class ResumeBanner extends StatelessWidget {
  /// Creates a resume banner.
  const ResumeBanner({super.key, required this.position, required this.onTap});

  /// Saved reading position to render.
  final ReadingPosition position;

  /// Tap handler (scrolls back to the saved ayah).
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.filled,
      onTap: onTap,
      child: Semantics(
        button: true,
        label:
            'Resume Surah ${position.surahNumber} at '
            'Ayah ${position.ayahNumber}',
        child: Row(
          children: <Widget>[
            const Icon(Icons.history),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Resume Surah ${position.surahNumber} · '
                'Ayah ${position.ayahNumber}',
                style: AppTypography.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
