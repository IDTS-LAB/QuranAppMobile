import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/l10n/app_localizations.dart';

/// Home page header: greeting, user name, date, and avatar.
///
/// The text column flexes and ellipsizes so long names cannot overflow
/// narrow (folded-phone) windows; styles come from the theme.
class HomePageHeader extends ConsumerWidget {
  /// Creates the home page header.
  const HomePageHeader({super.key, required this.name, this.profilePhoto});

  /// User display name.
  final String name;

  /// Avatar photo URL (falls back to the name initial).
  final String? profilePhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.homeGreeting,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                name,
                style: AppTypography.headlineLarge.copyWith(
                  color: AppColors.nobleGreen,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                localizations.homeDate,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.nobleGold,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          child: Text(
            profilePhoto ?? (name.isEmpty ? '?' : name[0]),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}
