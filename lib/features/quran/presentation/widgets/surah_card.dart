import 'package:flutter/material.dart';

import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/l10n/app_localizations.dart';

/// List card for a single surah.
///
/// Pure presentation: renders the [surah] entity and forwards taps via
/// [onTap]. No navigation, data access, or business logic inside.
///
/// Long names ellipsize instead of overflowing narrow (folded-phone)
/// windows; the Arabic trailing is width-constrained for the same reason.
class SurahCard extends StatelessWidget {
  /// Creates a surah list card.
  const SurahCard({
    super.key,
    required this.surah,
    required this.onTap,
    this.selected = false,
  });

  /// Surah entity to render.
  final Surah surah;

  /// Tap handler.
  final VoidCallback onTap;

  /// Highlights the card in two-pane selection contexts.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      onTap: onTap,
      child: Semantics(
        button: true,
        selected: selected,
        label: localizations.surahCardSemantics(
          surah.englishName,
          surah.englishMeaning,
          surah.ayahCount,
        ),
        // Transparent material so the ListTile ink/selection paints above
        // the card decoration instead of being hidden beneath it.
        child: Material(
          type: MaterialType.transparency,
          child: ListTile(
            selected: selected,
            selectedTileColor: AppColors.nobleGreen.withValues(alpha: 0.08),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
            ),
            leading: CircleAvatar(child: Text('${surah.number}')),
            title: Text(
              surah.englishName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              localizations.surahListSubtitle(
                surah.englishMeaning,
                surah.ayahCount,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: Text(
                surah.arabicName,
                style: AppTypography.arabicSmall,
                textDirection: TextDirection.rtl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
