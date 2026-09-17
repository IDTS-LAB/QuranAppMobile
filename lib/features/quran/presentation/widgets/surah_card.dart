import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/cards/app_card.dart';
import '../../domain/entities/surah.dart';

/// List card for a single surah.
///
/// Pure presentation: renders the [surah] entity and forwards taps via
/// [onTap]. No navigation, data access, or business logic inside.
class SurahCard extends StatelessWidget {
  const SurahCard({
    super.key,
    required this.surah,
    required this.onTap,
    this.selected = false,
  });

  final Surah surah;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        onTap: onTap,
        selected: selected,
        leading: CircleAvatar(child: Text('${surah.number}')),
        title: Text(surah.englishName),
        subtitle: Text(
          '${surah.englishMeaning} · ${surah.ayahCount} ayahs',
        ),
        trailing: Padding(
          padding: EdgeInsets.only(left: AppSpacing.sm),
          child: Text(
            surah.arabicName,
            style: AppTypography.arabicSmall,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
