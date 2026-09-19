# Responsive Design System

Constraint-based responsive foundation for the Quran app. Layout derives from
**available width** (`LayoutBuilder`) plus **foldable state** (`FoldInfo`) —
never from `screen width == device type`.

## Breakpoints

| Breakpoint  | Width       | Typical usage                            |
| ----------- | ----------- | ---------------------------------------- |
| Compact     | < 600dp     | Phones                                   |
| Medium      | 600–839dp   | Small tablets, large phones in landscape |
| Expanded    | 840–1199dp  | Tablets, foldables, desktop windows      |
| Large       | 1200–1599dp | Large tablets and desktop                |
| ExtraLarge  | ≥ 1600dp    | Wide desktop layouts                     |

```dart
final bp = context.appBreakpoint;
if (bp.isCompact) { /* single column */ }
if (context.isAtLeastExpanded) { /* two-pane candidate */ }
```

Custom thresholds: `Breakpoints.breakpointOf(width, const BreakpointConfig(...))`.
Legacy `AdaptiveSize` (compact/medium/expanded) still works — large maps to expanded.

## Responsive context (`context.*`)

`screenWidth`, `screenHeight`, `appBreakpoint`, `isCompact/isMedium/isExpanded/
isLarge/isExtraLarge`, `isAtLeastExpanded`, `isPortrait/isLandscape`,
`responsivePadding`, `foldInfo`.

Rule: page/scaffold level may use `MediaQuery`-backed getters; nested reusable
components must use `LayoutBuilder`-based builders so they react to their real
space (split views, side panels, fold regions).

## Responsive values

```dart
final padding = ResponsiveValue<EdgeInsets>(
  compact: const EdgeInsets.all(16),
  medium: const EdgeInsets.all(24),
  expanded: const EdgeInsets.all(32),
).resolve(context);

// Shorthand:
AppResponsive.value(context, compact: 16, medium: 24, expanded: 32);
// Width-based (inside LayoutBuilder):
AppResponsive.valueForWidth(width, compact: 1, expanded: 2);
// Fluid spacing (non-layout-critical only):
AppResponsive.interpolate(context, min: 16, max: 32);
```

Only `compact` is required; other breakpoints fall back toward it.

## Layout components

| Component | Default | Override |
| --------- | ------- | -------- |
| `ResponsivePadding` | 16/24/32/40/48 horizontal | per-breakpoint, `horizontal`/`vertical` |
| `ResponsiveContainer` | max width 560/720/1024/1200/1400, centered | `maxWidth`, `fullWidth`, `padding` |
| `ResponsiveGrid` | auto columns (min 160px, max 4) | `minItemWidth`, `maxColumns`, `spacing`, `childAspectRatio` |
| `ResponsiveFlex` | vertical → horizontal at expanded | directions, `breakpoint`, `spacing` |
| `ResponsiveTwoPaneLayout` | single → split (40/60) at expanded | `splitRatio`, `minSecondPaneWidth` |
| `HingeAwareTwoPane` | as above + hinge regions | `paneStrategy` (automatic/single/dual) |
| `FoldAwareLayout` | hinge clearance, tabletop stacking | `avoidHinge`, `secondary` |
| `AppSafeArea` | all sides | per-side flags |

```dart
AdaptiveScaffold(body: ...) // bottom bar / rail / sidebar automatically
ResponsiveContainer(
  child: ResponsiveGrid(children: [AppCard(child: ...), ...]),
)
```

## Navigation behavior

Compact → bottom `NavigationBar`; medium/expanded → `NavigationRail`;
large/extraLarge → extended rail (sidebar); spanned foldables → rail/sidebar
with hinge clearance; half-open horizontal hinge → tabletop (content above,
nav below). Selected index comes from the GoRouter shell — no string matching.

## Safe-area strategy

- Page scaffolds own system insets (`AppSafeArea` / `SafeArea` in shells).
- Full-screen content opts into edge-to-edge explicitly.
- Cards never apply safe-area padding; navigation handles its own insets.
- Foldable clearance is separate from safe areas (`FoldAwareLayout`).

## Adding a new responsive component

1. Zero-config defaults from theme tokens; derive from constraints via
   `LayoutBuilder` (not `MediaQuery.size` in nested widgets).
2. Expose a `variant`/enum + a few meaningful overrides (not every property).
3. Document purpose, defaults, customization, example (DartDoc).
4. Add unit/widget tests under `test/core/responsive/`.

## Common mistakes

- `MediaQuery.size.width` in reusable cards → use `ResponsiveBuilder`.
- Fixed `crossAxisCount: 2` grids → use `ResponsiveGrid`.
- Auto-scaling all fonts by width → use semantic styles + text-scaler.
- Centering every screen in max-width → `fullWidth: true` for edge-to-edge.
- Splitting panes without checking usable width → `minSecondPaneWidth`.
- Wrapping every widget in `SafeArea` → scaffold owns insets.
- Treating cutouts as hinges → `HingeUtils.isSeparatingFeature`.

## Testing approach

Unit: breakpoint resolution, value fallback, hinge math, pane rules
(`test/core/responsive/*_test.dart`). Widget: compact/medium/expanded/large
pumping via fixed window sizes, orientation, two-pane fallback, hinge layouts.
Run: `flutter test test/core/responsive/`.
