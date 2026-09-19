import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';

class GridMenuItem {
  GridMenuItem({
    required this.label,
    required this.icon,
    this.onTap,
    this.color = Colors.black,
  });

  final String label;
  final FaIcon icon;
  final Function()? onTap;
  final Color color;
}

class HomePageGridMenu extends StatelessWidget {
  const HomePageGridMenu({super.key, required this.items});

  final List<GridMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: AppSpacing.lg,
      mainAxisSpacing: AppSpacing.lg,
      crossAxisCount: 2,
      children: <Widget>[
        for (final GridMenuItem item in items)
          AppCard(
            padding: EdgeInsets.all(0),
            onTap: item.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Icon(item.icon.icon, size: 45, color: item.color),
                ),
                SizedBox(height: AppSpacing.md),
                AdaptiveText(
                  item.label,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: AppTypography.labelLarge.fontSize,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
