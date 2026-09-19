import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/buttons/app_secondary_button.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/indicators/app_badge.dart';
import 'package:quran_app/core/widgets/indicators/app_progress_bar.dart';
import 'package:quran_app/core/widgets/responsive_padding.dart';

class HomePageProgressCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.nobleGreen,
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative icon — NOT affected by padding
          Positioned(
            top: 12,
            right: -10,
            child: SizedBox(
              width: 110,
              height: 110,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.bookQuran,
                  size: 150,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),

          // Actual content
          ResponsivePadding(
            padding: ResponsivePaddingValues(
              compact: EdgeInsets.all(AppSpacing.md),
              medium: EdgeInsets.all(AppSpacing.lg),
              expanded: EdgeInsets.all(AppSpacing.xl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBadge(
                  label: 'Continue Reading',
                  variant: AppBadgeVariant.premium,
                ),

                SizedBox(height: AppSpacing.lg),

                Text(
                  'Al-Baqarah',
                  style: TextStyle(
                    fontSize: AppTypography.headlineLarge.fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ayah 142 • Juz 2',
                      style: TextStyle(color: AppColors.surface),
                    ),
                    Text(
                      '42%',
                      style: TextStyle(
                        color: AppColors.nobleGold,
                        fontSize: AppTypography.headlineSmall.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.lg),

                AppProgressBar(
                  value: 0.8,
                  backgroundColor: AppColors.canvas,
                  valueColor: AppColors.nobleGold,
                  height: AppSpacing.xs,
                ),

                SizedBox(height: AppSpacing.lg),

                AppSecondaryButton(
                  label: 'Read Now',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  onPressed: () {},
                  fullWidth: true,
                  trailingIcon: FaIcon(FontAwesomeIcons.arrowRight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
