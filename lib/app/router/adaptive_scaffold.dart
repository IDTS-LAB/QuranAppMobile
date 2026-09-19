import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_spacing.dart';

import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/foldable/fold_info.dart';

/// Navigation type override for [AdaptiveScaffold].
enum NavigationType {
  /// Bottom bar / rail / sidebar chosen from width + fold state.
  automatic,

  /// Force bottom navigation.
  bottomBar,

  /// Force navigation rail.
  rail,

  /// Force extended sidebar.
  sidebar,
}

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
/// | Layout    | Navigation                              |
/// | --------- | --------------------------------------- |
/// | Compact   | Bottom navigation                       |
/// | Medium    | Navigation rail                         |
/// | Expanded  | Navigation rail                         |
/// | Large+    | Extended navigation rail (sidebar)      |
/// | Dual-screen (separating hinge) | Rail/sidebar, content clear of hinge |
/// | Half-open (horizontal hinge)   | Content stacked above, nav usable below |
///
/// The selected index comes from the shell's `currentIndex` (synced with
/// GoRouter); taps navigate via shell branches — no hard-coded strings.
///
/// Safe areas: the scaffold owns system insets ([SafeArea] per shell);
/// keyboard insets are preserved (no `resizeToAvoidBottomInset: false`).
class AdaptiveScaffold extends StatelessWidget {
  /// Creates the adaptive app shell around [navigationShell].
  const AdaptiveScaffold({
    super.key,
    required this.navigationShell,
    this.navigationType = NavigationType.automatic,
  });

  /// GoRouter stateful shell rendered as the body.
  final StatefulNavigationShell navigationShell;

  /// Navigation override (default adapts to width + fold state).
  final NavigationType navigationType;

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
        final FoldInfo foldable = FoldInfo.fromContext(context);
        final breakpoint = Breakpoints.breakpointOf(constraints.maxWidth);
        final type = _resolveType(breakpoint, foldable);

        // Half-open tabletop: keep nav interactive below the hinge while
        // content uses the upper region.
        if (foldable.posture == FoldPosture.halfOpened &&
            foldable.hingeAxis == Axis.horizontal &&
            navigationType == NavigationType.automatic) {
          return _TabletopShell(
            onSelect: _goToBranch,
            hingeHeight: foldable.hingeBounds?.height ?? 0,
            child: navigationShell,
          );
        }

        switch (type) {
          case NavigationType.sidebar:
            return _ExpandedShell(
              onSelect: _goToBranch,
              hingeWidth: foldable.hingeBounds?.width ?? 0,
              extended: true,
              child: navigationShell,
            );
          case NavigationType.rail:
            if (breakpoint == AppBreakpoint.medium) {
              return _MediumShell(
                onSelect: _goToBranch,
                child: navigationShell,
              );
            }
            return _ExpandedShell(
              onSelect: _goToBranch,
              hingeWidth: foldable.hingeBounds?.width ?? 0,
              extended: false,
              child: navigationShell,
            );
          case NavigationType.bottomBar:
          case NavigationType.automatic:
            return _CompactShell(onSelect: _goToBranch, child: navigationShell);
        }
      },
    );
  }

  NavigationType _resolveType(AppBreakpoint bp, FoldInfo fold) {
    if (navigationType != NavigationType.automatic) return navigationType;
    // Spanned dual-screen always gets rail/sidebar (never bottom bar under
    // a hinge), even at narrower widths.
    if (fold.isSpanned || fold.isSeparating) {
      return bp.index >= AppBreakpoint.large.index
          ? NavigationType.sidebar
          : NavigationType.rail;
    }
    switch (bp) {
      case AppBreakpoint.compact:
        return NavigationType.bottomBar;
      case AppBreakpoint.medium:
      case AppBreakpoint.expanded:
        return NavigationType.rail;
      case AppBreakpoint.large:
      case AppBreakpoint.extraLarge:
        return NavigationType.sidebar;
    }
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
      body: SafeArea(bottom: false, child: child),
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: AppColors.nobleGreen);
              }
              return const IconThemeData(color: AppColors.disabled);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(color: AppColors.nobleGreen);
              }
              return const TextStyle(color: AppColors.disabled);
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
      body: SafeArea(
        child: Row(
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
                selectedIconTheme: const IconThemeData(
                  color: AppColors.nobleGreen,
                ),
                unselectedIconTheme: const IconThemeData(
                  color: AppColors.disabled,
                ),
                selectedLabelTextStyle: const TextStyle(
                  color: AppColors.nobleGreen,
                ),
                unselectedLabelTextStyle: const TextStyle(
                  color: AppColors.disabled,
                ),
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
      ),
    );
  }
}

class _ExpandedShell extends StatelessWidget {
  const _ExpandedShell({
    required this.onSelect,
    required this.hingeWidth,
    required this.child,
    this.extended = false,
  });

  final ValueChanged<int> onSelect;
  final double hingeWidth;
  final Widget child;

  /// Extended rail (sidebar) on large/extraLarge windows.
  final bool extended;

  @override
  Widget build(BuildContext context) {
    // Get selected index directly from the navigation shell for more reliable
    // state tracking across device modes and orientations
    final int selectedIndex = (child as StatefulNavigationShell).currentIndex;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme
                    .copyWith(primary: Colors.transparent),
              ),
              child: NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: onSelect,
                extended: extended,
                minExtendedWidth: 220,
                selectedIconTheme: const IconThemeData(
                  color: AppColors.nobleGreen,
                ),
                unselectedIconTheme: const IconThemeData(
                  color: AppColors.disabled,
                ),
                selectedLabelTextStyle: const TextStyle(
                  color: AppColors.nobleGreen,
                ),
                unselectedLabelTextStyle: const TextStyle(
                  color: AppColors.disabled,
                ),
                useIndicator: false,
                destinations: <NavigationRailDestination>[
                  for (final _Destination destination
                      in AdaptiveScaffold._destinations)
                    NavigationRailDestination(
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                      label: Text(destination.label),
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
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
      ),
    );
  }
}

/// Half-open tabletop: content above the hinge, navigation below.
///
/// Guarantees navigation stays clickable — no overlays above the bar, no
/// absorbed pointers; both regions rebuild on posture changes via the
/// parent `LayoutBuilder` + `MediaQuery` subscription.
class _TabletopShell extends StatelessWidget {
  const _TabletopShell({
    required this.onSelect,
    required this.hingeHeight,
    required this.child,
  });

  final ValueChanged<int> onSelect;
  final double hingeHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = (child as StatefulNavigationShell).currentIndex;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: child),
            if (hingeHeight > 0) SizedBox(height: hingeHeight),
            NavigationBar(
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
          ],
        ),
      ),
    );
  }
}
