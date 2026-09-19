# Component Usage Guide

All components work with minimal configuration and derive styling from the theme.

## Cards & surfaces

```dart
AppCard(child: Text('Hello'))
AppCard(variant: AppCardVariant.filled, onTap: () {}, child: content)
AppCard(padding: EdgeInsets.all(24), radius: ..., child: content)
AppSurface(child: content)
```

Padding renders inside the decoration; `margin` outside.

## Layout

```dart
ResponsivePadding(child: content)
ResponsivePadding(horizontal: 20, vertical: 12, child: content)
ResponsiveContainer(child: content)
ResponsiveContainer(maxWidth: 900, child: content)
ResponsiveContainer(fullWidth: true, child: edgeToEdgeContent)
ResponsiveGrid(children: items)
ResponsiveGrid(minItemWidth: 180, maxColumns: 4, spacing: 16, childAspectRatio: 1.2, children: items)
ResponsiveFlex(compactDirection: Axis.vertical, expandedDirection: Axis.horizontal, spacing: 16, children: [A(), B()])
ResponsiveTwoPaneLayout(first: list, second: detail)
ResponsiveTwoPaneLayout(splitRatio: 0.35, minSecondPaneWidth: 400, child: ...)
HingeAwareTwoPane(first: list, second: detail)
HingeAwareTwoPane(paneStrategy: PaneStrategy.single, first: a, second: b)
FoldAwareLayout(child: content)
FoldAwareLayout(child: video, secondary: controls)
AppSafeArea(top: false, child: fullBleedHeader)
```

Note: `ResponsiveGrid` scrolls by default; inside a parent scroll view pass
`shrinkWrap: true, physics: NeverScrollableScrollPhysics()`.

## Responsive values

```dart
final bp = context.appBreakpoint;
if (bp.isCompact) { /* ... */ }
ResponsiveValue<EdgeInsets>(compact: ..., medium: ..., expanded: ...).resolve(context);
AppResponsive.value(context, compact: 16, medium: 24, expanded: 32);
```

## Navigation

```dart
AdaptiveScaffold(navigationShell: shell) // shell from StatefulShellRoute
AdaptiveScaffold(navigationShell: shell, navigationType: NavigationType.rail)
```

Compact → bottom bar; medium/expanded → rail; large+ → sidebar; foldables adapt.

## Feedback

`AppLoading()`, `AppErrorView.fromError(error: e, onRetry: ...)`,
`AppEmptyView(message: ...)` — every async screen handles
initial/loading/success/empty/error.

## Spacing / motion / elevation

```dart
AppSpacing.md // 4/8/16/24/32/40/48/64 scale
AppSpacing.responsivePadding(context)
AppRadius.md // 8/16/24/32/pill
AppElevation.level1
AppMotion.normal // durations + Curves.standard
```
