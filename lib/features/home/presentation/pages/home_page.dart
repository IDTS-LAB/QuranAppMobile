import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/core/widgets/responsive_padding.dart';
import 'package:quran_app/core/widgets/typography/adaptive_text.dart';
import 'package:quran_app/features/home/presentation/widgets/goal_card.dart';
import 'package:quran_app/features/home/presentation/widgets/grid_menu.dart';
import 'package:quran_app/features/home/presentation/widgets/header.dart';
import 'package:quran_app/features/home/presentation/widgets/progress_card.dart';
import 'package:quran_app/features/home/presentation/widgets/recent_read_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<void> _onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.sizeOf(context);

    final menuItems = [
      GridMenuItem(
        label: "Read Quran",
        icon: FaIcon(FontAwesomeIcons.bookOpen),
        color: Colors.green,
      ),
      GridMenuItem(
        label: "Listen",
        icon: FaIcon(FontAwesomeIcons.headphones),
        color: Colors.blue,
      ),
      GridMenuItem(
        label: "Hifz Tracker",
        icon: FaIcon(FontAwesomeIcons.brain),
        color: Colors.orange,
      ),
      GridMenuItem(
        label: "Search",
        icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: ResponsivePadding(
              width: mediaSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomePageHeader(name: "Ahmed Razak", profilePhoto: null),

                  SizedBox(height: AppSpacing.xl),

                  HomePageProgressCard(),

                  SizedBox(height: AppSpacing.xl),

                  HomePageGoalCard(),

                  SizedBox(height: AppSpacing.xl),

                  HomePageGridMenu(items: menuItems),

                  SizedBox(height: AppSpacing.xl),

                  Row(
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

                  SizedBox(height: AppSpacing.md),

                  HomePageRecentReadCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
