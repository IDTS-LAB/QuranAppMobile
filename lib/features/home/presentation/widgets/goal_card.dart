import 'package:flutter/material.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/indicators/app_circular_progress.dart';
import 'package:quran_app/core/widgets/responsive_padding.dart';
import 'package:quran_app/l10n/app_localizations.dart';

class HomePageGoalCard extends StatelessWidget {
  const HomePageGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AppCard(
      padding: EdgeInsets.all(0),
      child: ResponsivePadding(
        padding: ResponsivePaddingValues(
          compact: EdgeInsetsGeometry.all(AppSpacing.lg),
          medium: EdgeInsetsGeometry.all(AppSpacing.xl),
          expanded: EdgeInsetsGeometry.all(AppSpacing.xxl),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.xs,
                children: [
                  Text(
                    localizations.goalTitle,
                    style: TextStyle(
                      color: AppColors.nobleGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: AppTypography.titleLarge.fontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    localizations.goalProgress,
                    style: TextStyle(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    localizations.goalStreak,
                    style: TextStyle(
                      color: AppColors.nobleGold,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppCircularProgress(
              size: 70,
              label: '80%',
              labelStyle: TextStyle(
                color: AppColors.nobleGreen,
                fontWeight: FontWeight.bold,
              ),
              value: 0.8,
              backgroundColor: AppColors.surface,
              valueColor: AppColors.nobleGold,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}
