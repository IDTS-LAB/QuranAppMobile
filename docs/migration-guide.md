# Migration Guide

Incremental adoption — do not rewrite every screen at once.

## Phase order (done for core, repeat per feature)

1. Wrap page bodies in `ResponsiveContainer` (use `fullWidth: true` for lists
   that should stay edge-to-edge, e.g. bookmarks).
2. Replace fixed `GridView.count` with `ResponsiveGrid` (+ `shrinkWrap` inside
   parent scrollers).
3. Replace side-by-side `Row`s with `ResponsiveFlex` (vertical on compact).
4. Replace manual expanded-only splits with `HingeAwareTwoPane`.
5. Replace `MediaQuery.sizeOf` width reads in nested widgets with
   `LayoutBuilder`/`ResponsiveBuilder`.
6. Replace width-scaled text with semantic styles (`AdaptiveText` now ignores
   width scaling; `QuranText` uses fixed semantic sizes + text-scaler).

## Already migrated

- `HomePage`: container + flex (progress/goal) + responsive grid menu.
- `HomePageGridMenu`: auto columns (was fixed 2).
- `SurahListPage`: `HingeAwareTwoPane` (was manual `AdaptiveLayout` row).
- `SearchPage`, `BookmarksPage`: `ResponsiveContainer`.
- `SurahDetailPage`: container + `FoldAwareLayout`.
- `AdaptiveScaffold`: 5 breakpoints + dual-screen + tabletop + safe areas.
- `AppCard`/`AppSurface`: padding-inside-decoration fix + `variant` API.
- `AdaptiveText`/`QuranText`: width scaling removed.

## Backward compatibility

- `Breakpoints.isCompact/isMedium/isExpanded` kept (deprecated semantics:
  medium 600–1024, expanded >1024). New code: `breakpointOf`/`AppBreakpoint`.
- `AdaptiveSize` kept (large maps to expanded); exhaustive switches need new
  cases only if matching on `AppBreakpoint`.
- `ResponsivePaddingValues` kept; `large`/`extraLarge` optional additions.
- `FoldableInfo`/`FoldablePosture` kept as deprecated shims over
  `FoldInfo`/`FoldPosture`.
- `AdaptiveText(baseWidth/minScale/maxScale)` params accepted, ignored.

## Remaining follow-ups (out of scope)

- Dark theme reuses light surfaces; high-contrast tuning.
- Android intent-filter / iOS associated-domain wiring for `quranapp://` links.
- Hinge-angle sensor plugin for true `halfOpened` detection (currently
  heuristic/`unknown` fallback).
- Golden tests for compact/tablet/foldable/light/dark (prioritize AppCard,
  AdaptiveScaffold, SurahListPage).
- Physical foldable-device verification (see `foldable-device-support.md`).
