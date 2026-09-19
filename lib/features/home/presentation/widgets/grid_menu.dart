import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/layout/responsive_grid.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';

/// Menu item model for [HomePageGridMenu].
class GridMenuItem {
  /// Creates a menu item.
  GridMenuItem({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.color = Colors.black,
  });

  /// Item label.
  final String title;

  final String? subtitle;

  /// Item icon.
  final FaIcon icon;

  /// Tap handler.
  final Function()? onTap;

  /// Accent color.
  final Color color;
}

/// Responsive dashboard menu: auto columns from available width.
///
/// Compact shows 2 columns; tablets/desktop expand to 3–4 without
/// stretching cards. Non-scrollable (parent scrolls).
class HomePageGridMenu extends StatelessWidget {
  /// Creates the responsive grid menu.
  const HomePageGridMenu({
    super.key,
    required this.items,
    this.minItemWidth = 160,
    this.maxColumns = 4,
  });

  /// Menu items.
  final List<GridMenuItem> items;

  /// Minimum item width driving column count.
  final double minItemWidth;

  /// Maximum columns regardless of width.
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      minItemWidth: minItemWidth,
      maxColumns: maxColumns,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        for (final GridMenuItem item in items)
          AppCard(
            padding: EdgeInsets.all(AppSpacing.md),
            onTap: item.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Icon(item.icon.icon, size: 24, color: item.color),
                ),
                const SizedBox(height: AppSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdaptiveText(
                      item.title,
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTypography.labelLarge.fontSize,
                      ),
                    ),
                    AdaptiveText(
                      item.subtitle ?? "",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppTypography.labelMedium.fontSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
