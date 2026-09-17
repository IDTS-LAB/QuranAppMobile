import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/responsive/foldable/foldable_info.dart';
import 'route_names.dart';

/// Single destination entry mapping a shell branch to its tab UI.
class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
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
      label: 'Surahs',
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book,
    ),
    _Destination(
      label: 'Search',
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
    ),
    _Destination(
      label: 'Bookmarks',
      icon: Icons.bookmark_outline,
      selectedIcon: Icons.bookmark,
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
    final int selectedIndex = RouteNames.locationToIndex(
      GoRouterState.of(context).uri.path,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final FoldableInfo foldable = FoldableInfo.fromContext(context);
        final double width = constraints.maxWidth;
        if (Breakpoints.isExpanded(width) || foldable.isDualScreen) {
          return _ExpandedShell(
            selectedIndex: selectedIndex,
            onSelect: _goToBranch,
            hingeWidth: foldable.hingeBounds?.width ?? 0,
            child: navigationShell,
          );
        }
        if (Breakpoints.isMedium(width)) {
          return _MediumShell(
            selectedIndex: selectedIndex,
            onSelect: _goToBranch,
            child: navigationShell,
          );
        }
        return _CompactShell(
          selectedIndex: selectedIndex,
          onSelect: _goToBranch,
          child: navigationShell,
        );
      },
    );
  }
}

class _CompactShell extends StatelessWidget {
  const _CompactShell({
    required this.selectedIndex,
    required this.onSelect,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelect,
        destinations: <Widget>[
          for (final _Destination destination in AdaptiveScaffold._destinations)
            NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label,
            ),
        ],
      ),
    );
  }
}

class _MediumShell extends StatelessWidget {
  const _MediumShell({
    required this.selectedIndex,
    required this.onSelect,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onSelect,
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              for (final _Destination destination
                  in AdaptiveScaffold._destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(destination.label),
                ),
            ],
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
    required this.selectedIndex,
    required this.onSelect,
    required this.hingeWidth,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final double hingeWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onSelect,
            extended: true,
            minExtendedWidth: 280,
            destinations: <NavigationRailDestination>[
              for (final _Destination destination
                  in AdaptiveScaffold._destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(destination.label),
                ),
            ],
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
