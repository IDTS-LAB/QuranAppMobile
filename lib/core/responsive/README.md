# Responsive system

Constraint-based responsive foundation. Derive layout from available width
(`LayoutBuilder`) + [FoldInfo](../foldable/fold_info.dart) — never from
`screen width == device type`.

## Files

- `breakpoints.dart` — `AppBreakpoint` (compact/medium/expanded/large/extraLarge) + `Breakpoints` thresholds.
- `responsive_value.dart` — `ResponsiveValue<T>` + `AppResponsive` helpers.
- `responsive_context.dart` — `context.appBreakpoint`, `isCompact`…, `responsivePadding`, `foldInfo`.
- `responsive_builder.dart` — `ResponsiveBuilder`, `ResponsiveValueBuilder` (constraint-based).
- `responsive_layout.dart` — `ResponsiveLayout` (columns, two-pane rule, max widths).
- `adaptive_layout.dart` — legacy `AdaptiveSize` compat (maps large→expanded).
- `foldable/` — `fold_info.dart`, `hinge_utils.dart`, `foldable_detector.dart`, `foldable_layout.dart`, `posture_observer.dart`, `foldable_info.dart` (legacy shim).

## Breakpoints

Compact <600 · Medium 600–839 · Expanded 840–1199 · Large 1200–1599 · ExtraLarge ≥1600.

```dart
final bp = context.appBreakpoint;
if (bp.isCompact) { /* single column */ }
final pad = ResponsiveValue<EdgeInsets>(compact: ..., expanded: ...).resolve(context);
```

## Foldables

```dart
final info = context.foldInfo;
if (info.isSeparating) { /* two-pane in usable regions, avoid info.hingeBounds */ }
```

`FoldPosture.unknown` = fall back to size-based layout. Cutouts never separate; only hinge/fold features do.
