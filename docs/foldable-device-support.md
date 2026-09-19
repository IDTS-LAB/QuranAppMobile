# Foldable Device Support

## Model

`FoldInfo` (`lib/core/responsive/foldable/fold_info.dart`) snapshots the window:

- `hasDisplayFeature` / `hasHinge` / `isFoldable`
- `posture`: `flat` | `halfOpened` | `folded` | `fullyOpen` | `unknown`
- `hingeAxis`, `hingeBounds`, `availableRegions`
- `isSpanned`, `isSeparating`

`FoldPosture.unknown` is the safe fallback when the OS exposes nothing
reliable — layouts then use window size + hinge geometry.

## Detection

- Source: `MediaQuery.displayFeatures` via `FoldInfo.fromContext` (or the
  pure, testable `FoldInfo.fromFeatures(features:windowSize:)` with simulated
  features in tests).
- Only hinge/fold features count as hinges; camera cutouts never separate.
- Only non-`unknown`-state features are separating.
- `HingeUtils.availableRegions` splits the window around separating features
  (vertical hinge → left/right; horizontal → top/bottom); cutouts ignored.
- `FoldableDetector` publishes one snapshot near the page root so descendants
  don't each subscribe to `MediaQuery`; `PostureObserver` rebuilds a subtree
  on posture changes.

## Layout rules

| Posture | Behavior |
| ------- | -------- |
| Flat | Standard responsive behavior |
| Half-open + horizontal hinge | Tabletop: primary content above, controls/nav below (`FoldAwareLayout` with `secondary`, `_TabletopShell` for nav) |
| Folded | Usable window is truth; compact layout, nav stays accessible |
| Spanned / separating hinge | Two panes in usable regions; content never under the hinge (`HingeAwareTwoPane`, hinge gap); fall back to single pane if a region < `minPaneWidth` |
| Unknown / no features | Size-based responsive fallback |

Never assume hinge orientation/dimensions; recalculate on window changes;
never place overlays/`AbsorbPointer` over navigation after posture changes.

## Components

```dart
FoldAwareLayout(child: content, secondary: controls)
HingeAwareTwoPane(first: list, second: detail, minPaneWidth: 320)
ResponsiveTwoPaneLayout(first: nav, second: content)
```

Pure rules live in `FoldableLayout.shouldUseTwoPanes / shouldUseTabletop /
hingeAvoidanceOffset` — unit-tested with simulated hinges
(`test/core/responsive/foldable_support_test.dart`).

## Verification status

- Simulated: unit + widget tests cover flat/folded/spanned/cutout/tabletop
  rules and two-pane fallback (`flutter test test/core/responsive/` → 52 pass).
- Physical hardware: NOT verified (no foldable device in CI/dev). Before
  release on foldables: verify touch targets near the hinge, posture-change
  rebuilds, and dual-screen spanning on a real device or the Android
  foldable emulator (`flutter test integration_test` on a foldable AVD).
