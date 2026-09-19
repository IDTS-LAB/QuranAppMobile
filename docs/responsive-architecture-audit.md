# Responsive Architecture Audit

**Date:** 2026-09-19
**Flutter:** 3.47.4 / Dart 3.13.3
**Scope:** `RESPONSIVE_DESIGN.md` implementation (responsive + foldable foundation)

## 1. Existing architecture

- Feature-first Clean Architecture (`app/`, `core/`, `features/quran/`, `features/home/`).
- State: `flutter_riverpod`; routing: `go_router` `StatefulShellRoute.indexedStack` (home/surahs/search/bookmarks, detail nested under `/surahs/:surahNumber`).
- Theme tokens exist: `AppColors`, `AppSpacing` (xs–xxxl+section), `AppRadius` (sm/md/lg/xl/pill), `AppShadows` (none/sm/md/xl), `AppTypography` (IBM Plex Sans + Arabic, semantic names), `AppTheme.light/dark` (Material3).
- Reusable widgets exist: `AppCard`, `AppSurface`, `AppPadding`, `ResponsivePadding`, `AdaptiveText`, `QuranText`, feedback (`AppLoading`, `AppErrorView`, `AppEmptyView`), indicators, buttons.
- Partial responsive system exists:
  - `core/responsive/breakpoints.dart` — 3 buckets only.
  - `core/responsive/adaptive_layout.dart` — `AdaptiveSize {compact, medium, expanded}` + `LayoutBuilder` builder.
  - `core/responsive/foldable/foldable_info.dart` — `FoldablePosture {folded, halfOpen, fullyOpen, unknown}` + `FoldableInfo.fromContext`.
  - `app/router/adaptive_scaffold.dart` — compact `NavigationBar` / medium `NavigationRail` / expanded rail+sidebar, index from shell, hinge-width spacer.
  - `SurahListPage` already does expanded two-pane list/detail via `AdaptiveLayout.builder`.

## 2. Current responsive limitations

1. **Breakpoints outdated (3 vs 5):** `compact <600`, `medium 600–1024`, `expanded >1024`. Spec requires Compact <600 / Medium 600–839 / Expanded 840–1199 / Large 1200–1599 / ExtraLarge ≥1600. No `large`/`extraLarge`, no custom config, medium range too wide (tablets misclassified).
2. **No `ResponsiveValue` / context extensions / `ResponsiveBuilder`:** breakpoint checks scattered; `AdaptiveText`/`QuranText` scale fonts by `MediaQuery.size.width / 360` — explicitly discouraged by spec ("do not automatically scale every font by screen width").
3. **`MediaQuery.size.width` in reusable components:** `FoldableInfo.fromContext`, `AdaptiveText`, `QuranText`, `HomePage` (`MediaQuery.sizeOf`) — should prefer `LayoutBuilder` constraints in nested widgets.
4. **`FoldableInfo` incomplete vs spec `FoldInfo`:** missing `posture.flat`, `hingeAxis`, `availableRegions`, `isSpanned`/`isSeparating` distinction, cutout vs hinge discrimination (only hinge/fold checked — good — but no `isSeparating` logic, no horizontal-hinge regions, no `halfOpen` inference path, no testable pure functions).
5. **Layout primitives missing:** no `ResponsiveContainer` (max-width centering), no `ResponsiveGrid` (auto columns), no `ResponsiveFlex` (direction switch), no `ResponsiveTwoPaneLayout`, no `FoldAwareLayout`/`HingeAwareTwoPane`, no `AppSafeArea` strategy (pages wrap `SafeArea` ad-hoc; cards apply padding/margin incorrectly).
6. **`AppCard` / `AppSurface` padding bug:** `Padding(margin) > Padding(padding) > Container` puts padding *outside* the decoration; `onTap` path wraps `InkWell` outside card with padding outside — ripple/decoration mismatch; `width: double.infinity` forces full width even in grids.
7. **`HomePageGridMenu` fixed 2 columns:** `GridView.count(crossAxisCount: 2)` overflows/stretches on tablets/desktop; hardcoded icon size 45; `HomePage` passes `width: mediaSize.width` into `ResponsivePadding` (defeats constraint-based layout); no `ResponsiveContainer`.
8. **Navigation gaps:** no Large/ExtraLarge extended-rail/sidebar variant, no half-open tabletop layout, no drawer fallback, hinge handled only as `SizedBox(width)` spacer (horizontal hinges ignored), no keyboard/safe-area guarantees documented.
9. **Theme gaps:** no `app_elevation.dart` / `app_motion.dart` tokens; `AppSpacing` has no responsive helper; dark theme reuses light surface colors (follow-up, out of scope).
10. **Tests:** no `test/core/responsive` coverage (breakpoints, values, fold logic, pane selection).

## 3. Existing reusable components (keep & improve, don't replace)

`AppCard`, `AppSurface`, `AppPadding`, `ResponsivePadding(+Values)`, `AdaptiveText`, `QuranText`, `AppLoading`, `AppErrorView`, `AppEmptyView`, buttons, badges, progress, `AdaptiveScaffold`, `SurahDetailContent`, `SurahCard`, `AyahTile`, `ResumeBanner`, home header/progress/goal/grid/recent cards.

## 4. Potential breaking changes

- `Breakpoints` gains `large`/`extraLarge` thresholds; `isMedium`/`isExpanded` semantics narrow (600–839 / 840+). Guarded: old statics kept as deprecated shims; `AdaptiveSize` gains `large`, `extraLarge` enum values (exhaustive switches must add cases — intentional, compiler-guided).
- `FoldablePosture` gains `flat`; `FoldableInfo` gains new fields with defaults — additive, backward compatible.
- `AppCard` fix changes visual padding nesting (padding now *inside* decoration) and adds `variant` param — existing `padding`/`margin` params preserved.
- `AdaptiveText` keeps API but changes scaling to semantic + text-scaler only (no width scaling) — visual font sizes stabilize on tablets (desired).
- `ResponsivePadding` keeps API; defaults extended to 5 breakpoints.

## 5. Implementation plan (matches spec Phase 2–6)

1. **Foundation:** 5-bucket `AppBreakpoint` + `Breakpoints` compat; `ResponsiveValue`; `ResponsiveContext` extensions; `ResponsiveBuilder`; `ResponsiveLayout` helpers; `FoldInfo` (+compat `FoldableInfo`), `FoldableDetector`, `HingeUtils`, `FoldableLayout` utils, `PostureObserver`; `AppElevation`, `AppMotion`, `AppSpacing.responsive`.
2. **Core components:** `ResponsiveContainer`, `ResponsiveGrid`, `ResponsiveFlex`, `ResponsiveTwoPaneLayout`, `FoldAwareLayout`, `HingeAwareTwoPane`, `AppSafeArea`; fix `AppCard`/`AppSurface`.
3. **Navigation:** upgrade `AdaptiveScaffold` (compact/medium/expanded/large + dual-screen + half-open stacking, safe areas).
4. **Screen migration (incremental):** `HomePage` (container+grid), `GridMenu` (responsive columns), `SurahListPage` (hinge-aware two-pane), `SearchPage`/`BookmarksPage` (container), `SurahDetailContent` unchanged logic.
5. **Validation:** `flutter analyze`, `flutter test` (new `test/core/responsive` unit+widget tests), docs (`responsive-architecture-audit.md` here, `responsive-design-system.md`, `foldable-device-support.md`, `component-usage-guide.md`, `migration-guide.md`).

## 6. Files to modify

- `lib/core/responsive/breakpoints.dart`, `adaptive_layout.dart`
- `lib/core/responsive/foldable/foldable_info.dart`
- `lib/core/widgets/responsive_padding.dart`, `cards/app_card.dart`, `surfaces/app_surface.dart`, `typography/adaptive_text.dart`
- `lib/app/router/adaptive_scaffold.dart`
- `lib/app/theme/app_spacing.dart`
- `lib/features/home/presentation/pages/home_page.dart`, `widgets/grid_menu.dart`
- `lib/features/quran/presentation/pages/surah_list_page.dart`, `search_page.dart`, `bookmarks_page.dart`

## 7. Files to remain unchanged

Business logic: use cases, repositories, DTOs/mappers, Drift tables/DAOs, Riverpod controllers/providers, `app_router.dart`/`route_names.dart`/`route_guards.dart`, error/result/network layers.
