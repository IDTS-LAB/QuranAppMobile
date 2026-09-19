import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/widgets/buttons/app_icon_button.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/responsive_padding.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';
import 'package:quran_app/l10n/app_localizations.dart';

class HomePageRecentReadCard extends StatelessWidget {
  const HomePageRecentReadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AppCard(
      padding: EdgeInsets.all(0),
      child: ResponsivePadding(
        padding: ResponsivePaddingValues(
          compact: EdgeInsetsGeometry.all(AppSpacing.md),
          medium: EdgeInsetsGeometry.all(AppSpacing.lg),
          expanded: EdgeInsetsGeometry.all(AppSpacing.xl),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // surah and ayah section
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.mutedSurface,
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: AdaptiveText(
                      "18",
                      style: TextStyle(
                        color: AppColors.nobleGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          localizations.recentSurahName,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AdaptiveText(
                          localizations.recentDetail,
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            AppIconButton(
              icon: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: AppColors.mutedSurface,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
