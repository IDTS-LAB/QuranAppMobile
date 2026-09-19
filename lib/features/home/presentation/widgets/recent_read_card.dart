import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/widgets/buttons/app_icon_button.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/responsive_padding.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';

class HomePageRecentReadCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
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
            Row(
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      "Al-Kahf",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AdaptiveText(
                      "Ayah 10 • Juz 15",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
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
