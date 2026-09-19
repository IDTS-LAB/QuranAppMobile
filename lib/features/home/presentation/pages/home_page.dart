import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/widgets/layout/app_safe_area.dart';
import 'package:quran_app/core/widgets/layout/responsive_container.dart';
import 'package:quran_app/core/widgets/layout/responsive_flex.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';
import 'package:quran_app/features/home/presentation/widgets/goal_card.dart';
import 'package:quran_app/features/home/presentation/widgets/grid_menu.dart';
import 'package:quran_app/features/home/presentation/widgets/header.dart';
import 'package:quran_app/features/home/presentation/widgets/progress_card.dart';
import 'package:quran_app/features/home/presentation/widgets/recent_read_card.dart';

/// Home page: constraint-based responsive layout, no fixed screen widths.
///
/// Compact: single column. Expanded+: progress/goal side-by-side via
/// [ResponsiveFlex]; content width constrained by [ResponsiveContainer].
class HomePage extends ConsumerStatefulWidget {
  /// Creates the home page.
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<void> _onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      GridMenuItem(
        label: "Read Quran",
        icon: const FaIcon(FontAwesomeIcons.bookOpen),
        color: Colors.green,
      ),
      GridMenuItem(
        label: "Listen",
        icon: const FaIcon(FontAwesomeIcons.headphones),
        color: Colors.blue,
      ),
      GridMenuItem(
        label: "Hifz Tracker",
        icon: const FaIcon(FontAwesomeIcons.brain),
        color: Colors.orange,
      ),
      GridMenuItem(
        label: "Search",
        icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      body: AppSafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomePageHeader(name: "Ahmed Razak", profilePhoto: null),

                  const SizedBox(height: AppSpacing.xl),

                  const ResponsiveFlex(
                    spacing: AppSpacing.xl,
                    children: [HomePageProgressCard(), HomePageGoalCard()],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  HomePageGridMenu(items: menuItems),

                  const SizedBox(height: AppSpacing.xl),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdaptiveText(
                        "Recently Read",
                        style: TextStyle(
                          color: AppColors.nobleGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AdaptiveText(
                        "See All",
                        style: TextStyle(
                          color: AppColors.nobleGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  const HomePageRecentReadCard(),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
