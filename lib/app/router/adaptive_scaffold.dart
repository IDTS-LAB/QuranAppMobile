import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/app/theme/app_spacing.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/foldable/foldable_info.dart';
import 'package:quran_app/app/theme/app_colors.dart';

import 'route_names.dart';

/// Single destination entry mapping a shell branch to its tab UI.
class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final FaIcon icon;
  final FaIcon selectedIcon;
}

/// App shell with adaptive navigation.
///
/// Compact widths use a [NavigationBar]; medium widths a [NavigationRail];
/// expanded widths a sidebar plus two-pane content. The selected index is
/// derived from [GoRouterState.uri] via [RouteNames.locationToIndex], and
/// taps navigate via the shell branches — no hard-coded route strings.
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<_Destination> _destinations = <_Destination>[
    _Destination(
      label: 'Home',
      icon: FaIcon(FontAwesomeIcons.solidHouse),
      selectedIcon: FaIcon(FontAwesomeIcons.solidHouse),
    ),
    _Destination(
      label: 'Quran',
      icon: FaIcon(FontAwesomeIcons.bookQuran),
      selectedIcon: FaIcon(FontAwesomeIcons.bookQuran),
    ),
    _Destination(
      label: 'Hifz',
      icon: FaIcon(FontAwesomeIcons.heartPulse),
      selectedIcon: FaIcon(FontAwesomeIcons.heartPulse),
    ),
    _Destination(
      label: 'Listen',
      icon: FaIcon(FontAwesomeIcons.headphones),
      selectedIcon: FaIcon(FontAwesomeIcons.headphones),
    ),
    _Destination(
      label: 'More',
      icon: FaIcon(FontAwesomeIcons.ellipsis),
      selectedIcon: FaIcon(FontAwesomeIcons.ellipsis),
    ),
  ];

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final FoldableInfo foldable = FoldableInfo.fromContext(context);
        final double width = constraints.maxWidth;
        if (Breakpoints.isExpanded(width) || foldable.isDualScreen) {
          return _ExpandedShell(
            onSelect: _goToBranch,
            hingeWidth: foldable.hingeBounds?.width ?? 0,
            child: navigationShell,
          );
        }
        if (Breakpoints.isMedium(width)) {
          return _MediumShell(onSelect: _goToBranch, child: navigationShell);
        }
        return _CompactShell(onSelect: _goToBranch, child: navigationShell);
      },
    );
  }
}

class _CompactShell extends StatelessWidget {
  const _CompactShell({required this.onSelect, required this.child});

  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get selected index directly from the navigation shell for more reliable
    // state tracking across device modes and orientations
    final int selectedIndex = (child as StatefulNavigationShell).currentIndex;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: AppColors.nobleGreen);
            }
            return IconThemeData(color: AppColors.disabled);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: AppColors.nobleGreen);
            }
            return TextStyle(color: AppColors.disabled);
          }),
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelect,
          destinations: <Widget>[
            for (final _Destination destination
                in AdaptiveScaffold._destinations)
              NavigationDestination(
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
                label: destination.label,
              ),
          ],
        ),
      ),
    );
  }
}

class _MediumShell extends StatelessWidget {
  const _MediumShell({required this.onSelect, required this.child});

  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get selected index directly from the navigation shell for more reliable
    // state tracking across device modes and orientations
    final int selectedIndex = (child as StatefulNavigationShell).currentIndex;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme
                  .copyWith(primary: Colors.transparent),
            ),
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelect,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(color: AppColors.nobleGreen),
              unselectedIconTheme: IconThemeData(color: AppColors.disabled),
              selectedLabelTextStyle: TextStyle(color: AppColors.nobleGreen),
              unselectedLabelTextStyle: TextStyle(color: AppColors.disabled),
              useIndicator: false,
              destinations: <NavigationRailDestination>[
                for (final _Destination destination
                    in AdaptiveScaffold._destinations)
                  NavigationRailDestination(
                    icon: destination.icon,
                    selectedIcon: destination.selectedIcon,
                    label: Text(destination.label),
                  ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ExpandedShell extends StatelessWidget {
  const _ExpandedShell({
    required this.onSelect,
    required this.hingeWidth,
    required this.child,
  });

  final ValueChanged<int> onSelect;
  final double hingeWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get selected index directly from the navigation shell for more reliable
    // state tracking across device modes and orientations
    final int selectedIndex = (child as StatefulNavigationShell).currentIndex;
    return Scaffold(
      body: Row(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme
                  .copyWith(primary: Colors.transparent),
            ),
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelect,
              extended: false,
              selectedIconTheme: IconThemeData(color: AppColors.nobleGreen),
              unselectedIconTheme: IconThemeData(color: AppColors.disabled),
              selectedLabelTextStyle: TextStyle(color: AppColors.nobleGreen),
              unselectedLabelTextStyle: TextStyle(color: AppColors.disabled),
              useIndicator: false,
              destinations: <NavigationRailDestination>[
                for (final _Destination destination
                    in AdaptiveScaffold._destinations)
                  NavigationRailDestination(
                    icon: destination.icon,
                    selectedIcon: destination.selectedIcon,
                    label: Text(destination.label),
                    padding: EdgeInsets.only(bottom: AppSpacing.md),
                  ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          // Keeps content clear of a vertical hinge on dual-screen devices.
          if (hingeWidth > 0) SizedBox(width: hingeWidth),
          Expanded(child: child),
        ],
      ),
    );
  }
}
