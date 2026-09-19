# Role

You are a Senior Flutter Architect, Responsive UI Engineer, and Design System Specialist.

Your task is to analyze and improve an **existing Flutter application** to make it fully responsive across different screen sizes, orientations, platforms, and foldable device postures.

You are working on an existing production-oriented codebase, not starting a new project.

Your implementation must prioritize:

* Maintainability
* Reusability
* Sensible defaults
* Minimal developer configuration
* Explicit customization when needed
* Consistent UI behavior
* Android and iOS compatibility
* Foldable device support
* Accessibility
* Performance
* Backward compatibility

Do not create unnecessary complexity or rewrite the entire application without justification.

---

# 1. Project Context

I have an existing Flutter application.

The project may already contain:

* Custom widgets
* Design tokens
* Theme configuration
* Responsive utilities
* Navigation
* State management
* Routing
* Screens and pages
* Shared components
* Platform-specific implementations

Your first responsibility is to inspect and understand the existing codebase before making architectural decisions.

## Required Initial Actions

1. Inspect the complete project structure.
2. Identify the Flutter SDK and Dart SDK versions.
3. Inspect `pubspec.yaml` and existing dependencies.
4. Identify the current architecture and coding conventions.
5. Inspect the existing theme, typography, colors, spacing, and component implementations.
6. Identify existing responsive utilities.
7. Identify existing foldable and display feature detection.
8. Inspect navigation and routing behavior.
9. Identify duplicated UI patterns.
10. Identify hardcoded dimensions and layout assumptions.
11. Inspect platform-specific code for Android and iOS.
12. Check whether existing components are already used across multiple screens.

Before modifying anything, create a concise architectural assessment in:

`docs/responsive-architecture-audit.md`

Include:

* Existing architecture
* Current responsive limitations
* Existing reusable components
* Potential breaking changes
* Recommended implementation plan
* Files that should be modified
* Files that should remain unchanged

Do not ask me to explain the project structure if it can be discovered by inspecting the repository.

---

# 2. Primary Objective

Transform the existing Flutter project into a responsive application that works correctly across:

## Mobile

* Small Android phones
* Standard Android phones
* Large Android phones
* Small iPhones
* Standard iPhones
* iPhone Pro Max-sized devices

## Tablets

* Small tablets
* Large tablets
* Android tablets
* iPads
* iPad split-screen layouts

## Desktop-Sized Windows

Support desktop-sized Flutter layouts where the existing application targets desktop or where the architecture can reasonably support it.

At minimum, the layout system must not break when the available width becomes significantly larger than a phone.

## Foldable Devices

Support devices with:

* Flat posture
* Half-open posture
* Folded posture
* Vertical hinges
* Horizontal hinges
* Dual-screen layouts
* Spanned application windows
* Single-screen layouts
* Configuration changes caused by folding and unfolding
* Orientation changes

The implementation must use Flutter's supported display feature APIs and compatible platform integrations where necessary.

Do not assume that every foldable device has the same hinge orientation or screen dimensions.

---

# 3. Non-Negotiable Design Principles

## 3.1 Sensible Defaults

Every reusable component must work immediately with minimal configuration.

Bad:

```dart
ResponsiveCard(
  padding: AppSpacing.all(
    compact: 12,
    medium: 16,
    expanded: 24,
  ),
  radius: 12,
  elevation: 2,
  margin: EdgeInsets.zero,
  backgroundColor: AppColors.surface,
  width: double.infinity,
  responsive: true,
  ...
);
```

The developer should not need to configure standard properties repeatedly.

Preferred:

```dart
AppCard(
  child: Text('Hello'),
);
```

The component should automatically use:

* Appropriate padding
* Theme colors
* Standard border radius
* Suitable elevation
* Responsive behavior
* Accessibility defaults
* Platform-appropriate interaction behavior

Manual customization must still be possible:

```dart
AppCard(
  padding: EdgeInsets.all(24),
  radius: 20,
  elevation: 4,
  backgroundColor: Colors.white,
  child: Text('Custom Card'),
);
```

### Rule

**Default configuration should cover approximately 80–90% of common use cases.**

The remaining use cases must be supported through optional parameters or clearly documented extension points.

Do not force developers to configure properties that can be derived from:

* Theme
* Screen size
* Platform
* Component variant
* Accessibility settings
* Foldable posture
* Parent layout constraints

---

## 3.2 Responsive by Default

Avoid creating separate widgets for every screen size unless the UI structure genuinely changes.

Bad:

```dart
MobileCard()
TabletCard()
DesktopCard()
FoldableCard()
```

Preferred:

```dart
AppCard()
```

The component adapts automatically based on its constraints.

Use `LayoutBuilder` and constraint-based decisions whenever possible.

Avoid relying exclusively on:

```dart
MediaQuery.of(context).size.width
```

inside deeply nested reusable components.

Components should respond to the available space rather than the entire device screen.

---

## 3.3 Explicit Customization

Every important default must be overridable.

For example:

```dart
AppSpacing.responsive(
  compact: 12,
  medium: 16,
  expanded: 24,
);
```

Or:

```dart
AppCard(
  padding: EdgeInsets.symmetric(horizontal: 24),
);
```

Or:

```dart
AppResponsiveGrid(
  minItemWidth: 180,
  maxColumns: 4,
  spacing: 16,
  childAspectRatio: 1.2,
  children: items,
);
```

Defaults must be predictable and documented.

Avoid excessive configuration parameters that expose internal implementation details unnecessarily.

---

# 4. Responsive Architecture

Create or improve a centralized responsive system.

Suggested structure:

```text
lib/
└── core/
    ├── responsive/
    │   ├── breakpoints.dart
    │   ├── responsive_context.dart
    │   ├── responsive_value.dart
    │   ├── responsive_builder.dart
    │   ├── responsive_layout.dart
    │   ├── adaptive_layout.dart
    │   ├── foldable/
    │   │   ├── fold_info.dart
    │   │   ├── foldable_detector.dart
    │   │   ├── hinge_utils.dart
    │   │   ├── foldable_layout.dart
    │   │   └── posture_observer.dart
    │   └── README.md
    │
    ├── theme/
    │   ├── app_theme.dart
    │   ├── app_colors.dart
    │   ├── app_spacing.dart
    │   ├── app_radius.dart
    │   ├── app_typography.dart
    │   ├── app_elevation.dart
    │   └── app_motion.dart
    │
    └── widgets/
        ├── layout/
        ├── containers/
        ├── cards/
        ├── navigation/
        ├── buttons/
        ├── inputs/
        ├── feedback/
        └── accessibility/
```

Adapt this structure to the existing project rather than blindly duplicating files.

---

# 5. Breakpoint System

Implement a centralized breakpoint system.

Use width-based breakpoints as defaults, but make them configurable.

Suggested default breakpoints:

| Breakpoint  |       Width | Typical Usage                             |
| ----------- | ----------: | ----------------------------------------- |
| Compact     |     < 600dp | Phones                                    |
| Medium      |   600–839dp | Small tablets, large phones in landscape  |
| Expanded    |  840–1199dp | Tablets, foldables, desktop-sized windows |
| Large       | 1200–1599dp | Large tablets and desktop                 |
| Extra Large |    ≥ 1600dp | Wide desktop layouts                      |

These are starting points, not rigid rules.

The implementation must:

* Avoid hardcoding breakpoints throughout the application.
* Centralize breakpoint definitions.
* Support custom breakpoint configurations.
* Use available width rather than physical device labels.
* Handle orientation changes.
* Support window resizing.

Example:

```dart
enum AppBreakpoint {
  compact,
  medium,
  expanded,
  large,
  extraLarge,
}
```

Example usage:

```dart
final breakpoint = context.appBreakpoint;

if (breakpoint.isCompact) {
  // Compact layout
}
```

Or:

```dart
ResponsiveValue<double>(
  compact: 16,
  medium: 24,
  expanded: 32,
).resolve(context);
```

The API should be concise and type-safe.

---

# 6. Responsive Context Extensions

Create convenient context extensions.

Example:

```dart
extension ResponsiveContext on BuildContext {
  double get screenWidth;
  double get screenHeight;

  AppBreakpoint get breakpoint;

  bool get isCompact;
  bool get isMedium;
  bool get isExpanded;
  bool get isLarge;
  bool get isExtraLarge;

  bool get isPortrait;
  bool get isLandscape;

  bool get isMobile;
  bool get isTablet;
  bool get isDesktop;

  EdgeInsets get responsivePadding;

  FoldInfo get foldInfo;
}
```

Usage:

```dart
Padding(
  padding: context.responsivePadding,
  child: content,
);
```

However, do not expose misleading device classifications.

For example, a foldable device in folded mode may have a compact window despite being physically large.

Prefer distinguishing:

* Window size
* Device category, when reliably known
* Foldable posture
* Available layout regions

---

# 7. Responsive Value System

Implement a reusable responsive value resolver.

It must support:

* Numbers
* EdgeInsets
* Text styles
* Widget configurations
* Enums
* Colors where appropriate
* Custom objects

Example:

```dart
final padding = ResponsiveValue<EdgeInsets>(
  compact: const EdgeInsets.all(16),
  medium: const EdgeInsets.all(24),
  expanded: const EdgeInsets.all(32),
).resolve(context);
```

Provide a convenient helper for common cases:

```dart
AppResponsive.value(
  context,
  compact: 16,
  medium: 24,
  expanded: 32,
);
```

Optional interpolation may be supported for numeric values:

```dart
AppResponsive.interpolate(
  context,
  min: 16,
  max: 32,
);
```

Do not overengineer this system if a simpler implementation meets the requirements.

---

# 8. Responsive Layout Components

Create reusable layout primitives that work without repetitive configuration.

## 8.1 ResponsivePadding

Default behavior:

* Compact: 16dp horizontal padding
* Medium: 24dp
* Expanded: 32dp
* Large: 40dp
* Extra Large: centered content with reasonable maximum width

Usage:

```dart
ResponsivePadding(
  child: content,
);
```

Customization:

```dart
ResponsivePadding(
  compact: EdgeInsets.all(12),
  medium: EdgeInsets.all(20),
  expanded: EdgeInsets.all(32),
  child: content,
);
```

Support individual axis customization.

---

## 8.2 ResponsiveContainer

Create a container that automatically:

* Applies standard maximum content width
* Centers content on large screens
* Prevents excessive line lengths
* Supports full-width mode
* Handles safe areas when explicitly requested
* Adapts horizontal padding

Usage:

```dart
ResponsiveContainer(
  child: content,
);
```

Customization:

```dart
ResponsiveContainer(
  maxWidth: 1200,
  alignment: Alignment.topCenter,
  padding: EdgeInsets.symmetric(horizontal: 24),
  child: content,
);
```

Do not force every screen into a centered max-width container when edge-to-edge layouts are more appropriate.

---

## 8.3 ResponsiveRow / ResponsiveColumn

Create layout primitives supporting:

* Spacing
* Alignment
* Main axis size
* Responsive direction
* Wrapping
* Cross-axis alignment
* Overflow handling

Example:

```dart
ResponsiveFlex(
  compactDirection: Axis.vertical,
  expandedDirection: Axis.horizontal,
  spacing: 16,
  children: [
    WidgetA(),
    WidgetB(),
  ],
);
```

Defaults should prevent common overflow issues.

---

## 8.4 ResponsiveGrid

Create a responsive grid with automatic column calculation.

Usage:

```dart
ResponsiveGrid(
  children: items,
);
```

The grid should automatically determine the number of columns based on:

* Available width
* Minimum item width
* Maximum columns
* Spacing
* Padding

Customization:

```dart
ResponsiveGrid(
  minItemWidth: 160,
  maxColumns: 4,
  spacing: 16,
  runSpacing: 16,
  childAspectRatio: 1.2,
  children: items,
);
```

Requirements:

* Avoid overflow.
* Avoid unnecessarily stretched cards.
* Support non-scrollable and scrollable modes.
* Work inside `SingleChildScrollView` where appropriate.
* Avoid nested scroll conflicts.
* Preserve performance for large lists.
* Support consistent item sizing.

---

## 8.5 ResponsiveTwoPaneLayout

Create a layout for tablets and foldable devices.

Default behavior:

* Compact: single pane
* Medium: single pane or adaptive split
* Expanded: two-pane when appropriate
* Foldable with separating hinge: use available regions

Usage:

```dart
ResponsiveTwoPaneLayout(
  first: NavigationPanel(),
  second: ContentPanel(),
);
```

Customization:

```dart
ResponsiveTwoPaneLayout(
  first: NavigationPanel(),
  second: ContentPanel(),
  splitRatio: 0.35,
  minSecondPaneWidth: 400,
  breakpoint: AppBreakpoint.expanded,
);
```

The component must not blindly split the screen when the second pane becomes unusable.

---

# 9. Foldable Device Support

This is a core requirement.

Implement a robust foldable abstraction that works with Flutter's display feature information.

## 9.1 FoldInfo

Create a model that represents the current window configuration.

Suggested properties:

```dart
class FoldInfo {
  final bool hasDisplayFeature;
  final bool hasHinge;
  final bool isFoldable;
  final FoldPosture posture;
  final Axis? hingeAxis;
  final Rect? hingeBounds;
  final List<Rect> availableRegions;
  final bool isSpanned;
  final bool isSeparating;
}
```

Use an appropriate posture enum:

```dart
enum FoldPosture {
  flat,
  halfOpened,
  folded,
  unknown,
}
```

Do not assume the OS always exposes a reliable semantic posture.

When posture cannot be determined, use `unknown` and fall back to safe layout behavior.

---

## 9.2 Display Feature Detection

Use the appropriate Flutter APIs and platform integrations available for the project's SDK.

Inspect `MediaQuery.displayFeatures` and related APIs.

Handle:

* Hinges
* Folds
* Cutouts
* Display feature bounds
* Separating features
* Non-separating features

Do not treat every display feature as a hinge.

A camera cutout and a physical hinge have different layout implications.

---

## 9.3 Foldable Layout Rules

### Flat Posture

Use standard responsive layouts.

```text
Normal responsive behavior
```

### Half-Open Posture

Adapt the layout to the device's available regions and posture.

Potential behavior:

* Keep primary content in the usable region.
* Avoid placing important controls directly across a hinge.
* Support tabletop-style layouts when appropriate.
* Avoid assuming the hinge always divides the screen vertically.

### Folded Posture

Treat the usable application window as the primary source of truth.

If the app is displayed on only one screen:

* Use a compact layout when appropriate.
* Ensure navigation remains accessible.
* Avoid relying on stale display feature state.
* Recalculate constraints when the window changes.

### Spanned / Dual-Screen Layout

When the application spans multiple regions:

* Detect separating hinges.
* Calculate usable regions.
* Avoid rendering important content underneath a hinge.
* Support two-pane layouts when both regions have sufficient dimensions.
* Allow manual override of pane behavior.

---

# 10. Foldable Layout Components

Create reusable components.

## 10.1 FoldAwareLayout

Usage:

```dart
FoldAwareLayout(
  child: content,
);
```

Default behavior:

* Detect display features.
* Avoid hinge overlap where possible.
* Use normal layout when no fold exists.
* Rebuild when display features change.

Customization:

```dart
FoldAwareLayout(
  avoidHinge: true,
  respectSafeAreas: true,
  child: content,
);
```

---

## 10.2 HingeAwareTwoPane

Usage:

```dart
HingeAwareTwoPane(
  first: FirstPane(),
  second: SecondPane(),
);
```

Default behavior:

* Single pane on compact screens.
* Two panes when usable regions support it.
* Hinge-aware separation.
* Safe fallback when hinge information is unavailable.

Customization:

```dart
HingeAwareTwoPane(
  first: FirstPane(),
  second: SecondPane(),
  paneStrategy: PaneStrategy.automatic,
  minPaneWidth: 320,
);
```

---

## 10.3 Foldable Navigation Layout

Ensure navigation works in all postures.

Support:

* Bottom navigation on compact screens.
* Navigation rail on medium and expanded screens.
* Navigation drawer when appropriate.
* Two-pane navigation on large displays.
* Fold-aware navigation when the screen is separated.

Requirements:

* Navigation must remain clickable in folded mode.
* Do not place invisible overlays above navigation.
* Do not rely on incorrect hit-test regions after posture changes.
* Ensure `SafeArea`, `MediaQuery`, and display feature calculations do not block taps.
* Rebuild navigation layout when constraints or display features change.
* Avoid nested `AbsorbPointer`, `IgnorePointer`, or gesture detectors that block interaction.
* Verify actual touch interaction on physical devices when possible.

---

# 11. Adaptive Navigation Scaffold

Create or improve an adaptive navigation scaffold.

Example:

```dart
AdaptiveScaffold(
  body: HomePage(),
);
```

Default behavior:

| Layout   | Default Navigation                   |
| -------- | ------------------------------------ |
| Compact  | Bottom navigation                    |
| Medium   | Navigation rail or bottom navigation |
| Expanded | Navigation rail                      |
| Large    | Extended navigation rail or sidebar  |
| Foldable | Adapt based on usable regions        |

Customization:

```dart
AdaptiveScaffold(
  navigationType: NavigationType.automatic,
  destinations: destinations,
  body: content,
);
```

Requirements:

* Support safe areas.
* Support keyboard visibility.
* Support orientation changes.
* Support foldable layout changes.
* Avoid content being hidden behind navigation.
* Use platform-appropriate semantics.
* Preserve existing routing behavior.
* Do not break deep links or browser history where applicable.

---

# 12. Design System with Sensible Defaults

Create or improve a centralized design system.

Every reusable component should derive defaults from the theme.

## 12.1 Colors

Use semantic colors instead of hardcoded colors.

Example:

```dart
AppColors.surface
AppColors.background
AppColors.primary
AppColors.onSurface
AppColors.error
```

Components should automatically use theme-aware colors.

Support:

* Light theme
* Dark theme
* High contrast where practical
* Dynamic color where already supported or appropriate

Avoid hardcoding colors inside reusable components.

---

## 12.2 Spacing

Create centralized spacing tokens.

Example:

```dart
AppSpacing.xs
AppSpacing.sm
AppSpacing.md
AppSpacing.lg
AppSpacing.xl
AppSpacing.xxl
```

Spacing should be consistent across all components.

Provide responsive spacing where useful:

```dart
AppSpacing.responsive(context).horizontal;
```

Do not make every spacing value responsive by default if it harms visual consistency.

---

## 12.3 Radius

Create standard radius tokens:

```dart
AppRadius.sm
AppRadius.md
AppRadius.lg
AppRadius.xl
AppRadius.full
```

Components should use these defaults automatically.

---

## 12.4 Typography

Typography must:

* Scale appropriately across screen sizes.
* Respect text scaling accessibility settings.
* Avoid clipping.
* Support long text.
* Support RTL languages.
* Support Arabic typography where applicable.
* Use theme-based text styles.
* Avoid hardcoded font sizes scattered throughout the project.

Do not automatically scale every font based on screen width.

Prefer semantic typography with controlled responsive adjustments.

Example:

```dart
AppTypography.titleLarge
AppTypography.bodyMedium
AppTypography.labelLarge
```

---

# 13. Reusable Components Must Be Zero-Configuration

Audit and improve existing components.

Prioritize:

## Containers

* `AppCard`
* `AppSurface`
* `AppSection`
* `AppContainer`

## Buttons

* `AppPrimaryButton`
* `AppSecondaryButton`
* `AppTextButton`
* `AppIconButton`
* `AppOutlinedButton`

## Inputs

* `AppTextField`
* `AppSearchField`
* `AppDropdown`
* `AppCheckbox`
* `AppRadio`
* `AppSwitch`

## Feedback

* `AppLoading`
* `AppErrorState`
* `AppEmptyState`
* `AppSnackbar`
* `AppDialog`

## Layout

* `ResponsivePadding`
* `ResponsiveContainer`
* `ResponsiveGrid`
* `ResponsiveFlex`
* `ResponsiveTwoPaneLayout`
* `FoldAwareLayout`

## Navigation

* `AdaptiveScaffold`
* `AdaptiveNavigationBar`
* `AdaptiveNavigationRail`
* `AdaptiveNavigationDrawer`

Every component must:

1. Have sensible defaults.
2. Derive styling from the theme.
3. Be responsive where appropriate.
4. Support manual overrides.
5. Avoid unnecessary required parameters.
6. Expose only meaningful customization options.
7. Support accessibility.
8. Be documented.
9. Follow existing project conventions.
10. Avoid breaking existing usages unless necessary.

---

# 14. API Design Guidelines

## Bad API

```dart
AppCard(
  padding: null,
  backgroundColor: null,
  radius: null,
  border: null,
  elevation: null,
  shadowColor: null,
  width: null,
  height: null,
  alignment: null,
  margin: null,
  responsive: true,
  enableAnimation: true,
  ...
);
```

This exposes too many implementation details.

## Preferred API

```dart
AppCard(
  variant: AppCardVariant.elevated,
  child: content,
);
```

Defaults should handle most use cases.

For advanced customization:

```dart
AppCard(
  padding: EdgeInsets.all(24),
  decoration: customDecoration,
  child: content,
);
```

Use enums and meaningful abstractions instead of multiple boolean flags when appropriate.

Avoid boolean combinations that create invalid states.

---

# 15. Accessibility Requirements

All components must support:

* Text scaling
* Screen readers
* Semantic labels
* Keyboard navigation where applicable
* Sufficient touch target sizes
* Focus states
* High contrast considerations
* Reduced motion preferences where practical
* RTL layouts
* Dynamic content sizes

Do not use fixed heights for text-heavy components unless text overflow is explicitly handled.

Buttons and interactive elements should meet platform accessibility guidelines.

---

# 16. Android and iOS Compatibility

The implementation must work on both Android and iOS.

Verify:

* Safe areas
* Status bar
* Navigation bar
* Gesture navigation
* iOS home indicator
* Dynamic Island and display cutouts
* Orientation changes
* Keyboard appearance
* Keyboard dismissal
* Platform-specific navigation behavior
* Scroll physics where appropriate
* Accessibility behavior
* Foldable-specific Android behavior

Do not introduce Android-only APIs into shared Dart code without an abstraction.

Do not assume iOS supports Android foldable APIs.

Use platform capability detection where required.

---

# 17. Safe Area Strategy

Avoid blindly wrapping every widget in `SafeArea`.

Instead, establish clear responsibilities.

For example:

* Page-level scaffolds manage system insets.
* Full-screen content explicitly opts into edge-to-edge behavior.
* Reusable cards do not apply safe area padding.
* Navigation components handle their own required insets.
* Foldable layouts account for display features separately from safe areas.

Support configuration:

```dart
AppSafeArea(
  top: true,
  bottom: true,
  left: true,
  right: true,
  child: content,
);
```

Defaults should be appropriate for the component's responsibility.

---

# 18. Performance Requirements

Responsive behavior must not introduce unnecessary rebuilds.

Requirements:

* Avoid expensive calculations in `build`.
* Avoid unnecessary `MediaQuery` subscriptions.
* Use granular inherited data where beneficial.
* Avoid rebuilding the entire application for minor layout changes.
* Avoid expensive layout nesting.
* Use lazy lists and grids for large datasets.
* Avoid excessive `IntrinsicHeight` and `IntrinsicWidth`.
* Avoid unnecessary animations during posture changes.
* Preserve scroll position during responsive transitions where possible.

Profile before introducing complex optimizations.

---

# 19. Testing Requirements

Create tests for responsive behavior.

## Unit Tests

Test:

* Breakpoint resolution
* Responsive value resolution
* Fold posture classification
* Hinge detection
* Available region calculations
* Pane selection logic
* Default component configurations

## Widget Tests

Test:

* Compact layout
* Medium layout
* Expanded layout
* Large layout
* Orientation changes
* Text scaling
* Navigation interaction
* Grid column changes
* Two-pane fallback behavior
* Hinge-aware layout behavior

## Golden Tests

Where practical, create golden tests for:

* Compact phone
* Large phone
* Tablet
* Foldable single pane
* Foldable two-pane
* Light theme
* Dark theme

Do not create hundreds of unnecessary golden tests.

Prioritize reusable components and critical screens.

---

# 20. Required Documentation

Create:

```text
docs/
├── responsive-architecture-audit.md
├── responsive-design-system.md
├── foldable-device-support.md
├── component-usage-guide.md
└── migration-guide.md
```

Documentation must explain:

* Breakpoints
* Responsive context
* Responsive values
* Layout components
* Foldable support
* Default configurations
* Manual overrides
* Navigation behavior
* Safe area strategy
* How to add new responsive components
* Common mistakes
* Testing approach

Each reusable component should include DartDoc explaining:

* Purpose
* Default behavior
* Customization
* Example usage
* Responsive behavior
* Limitations

---

# 21. Migration Strategy

Do not rewrite every screen immediately.

Use this approach:

## Phase 1 — Audit

Understand the existing codebase.

## Phase 2 — Foundation

Implement:

* Breakpoints
* Responsive context
* Responsive values
* Theme tokens
* Foldable detection
* Layout utilities

## Phase 3 — Core Components

Improve the most commonly used components.

## Phase 4 — Navigation

Implement adaptive navigation and foldable-safe interaction.

## Phase 5 — Screen Migration

Migrate screens incrementally.

## Phase 6 — Validation

Test all supported layout classes and device configurations.

Maintain backward compatibility wherever practical.

If an existing component is already well-designed, improve it rather than replacing it unnecessarily.

---

# 22. Implementation Rules

Follow these rules strictly:

1. Do not ask me for clarification about implementation details that can be reasonably inferred from the existing codebase.
2. Do not replace the current architecture without inspecting it.
3. Do not introduce dependencies without explaining why they are needed.
4. Prefer Flutter SDK APIs over unnecessary third-party packages.
5. Reuse existing dependencies when suitable.
6. Avoid duplicate responsive utilities.
7. Avoid hardcoded screen dimensions.
8. Avoid hardcoded device-specific assumptions.
9. Avoid unnecessary platform-specific branching.
10. Preserve existing business logic.
11. Preserve existing state management.
12. Preserve existing navigation and routing unless improvements are required.
13. Do not break existing component APIs unnecessarily.
14. Use sensible defaults for all reusable components.
15. Allow manual customization when required.
16. Ensure all components compile independently.
17. Keep code readable and maintainable.
18. Follow the existing project's lint rules.
19. Use null safety correctly.
20. Do not leave TODO placeholders for core functionality.
21. Do not claim a feature works without testing it.
22. Do not silently ignore existing errors.
23. If a requirement conflicts with the existing architecture, document the trade-off and implement the safest compatible solution.

---

# 23. Definition of Done

The task is complete only when:

### Architecture

* [ ] Existing project audited.
* [ ] Responsive architecture documented.
* [ ] Breakpoints centralized.
* [ ] Responsive values implemented.
* [ ] Foldable abstraction implemented.
* [ ] Duplicate utilities removed or consolidated.

### Components

* [ ] Existing shared components audited.
* [ ] Components have sensible defaults.
* [ ] Manual overrides work.
* [ ] Components use theme tokens.
* [ ] Components support accessibility.
* [ ] Components avoid unnecessary required configuration.

### Responsive Behavior

* [ ] Compact layouts work.
* [ ] Medium layouts work.
* [ ] Expanded layouts work.
* [ ] Large layouts work.
* [ ] Orientation changes work.
* [ ] Large screen content does not stretch excessively.
* [ ] No overflow errors occur under supported constraints.

### Foldable Support

* [ ] Flat posture works.
* [ ] Half-open posture is handled safely.
* [ ] Folded posture works.
* [ ] Hinges are detected correctly.
* [ ] Content avoids hinge overlap where applicable.
* [ ] Two-pane layouts use usable regions.
* [ ] Navigation remains interactive after posture changes.
* [ ] Fallback behavior works when display feature information is unavailable.

### Platform Support

* [ ] Android behavior verified.
* [ ] iOS behavior verified.
* [ ] Safe areas handled correctly.
* [ ] Keyboard behavior tested.
* [ ] Accessibility behavior tested.

### Quality

* [ ] `flutter analyze` passes.
* [ ] Relevant tests pass.
* [ ] No new analyzer warnings.
* [ ] No obvious layout overflow errors.
* [ ] Documentation completed.
* [ ] Changes summarized clearly.

---

# 24. Final Deliverables

At the end of the implementation, provide:

1. Summary of architectural changes.
2. List of created files.
3. List of modified files.
4. List of removed files, if any.
5. Explanation of responsive behavior.
6. Explanation of foldable behavior.
7. Explanation of component defaults.
8. Examples of manual customization.
9. Migration notes for existing screens.
10. Testing results.
11. Known limitations.
12. Recommended next steps.

Do not simply report that the implementation is complete.

Show concrete examples of how developers can now use the system with minimal configuration.

---

# Final Instruction

Start by auditing the existing project.

Then implement the responsive and foldable foundation before migrating screens.

Prioritize a stable, maintainable architecture over a rushed rewrite.

**The final developer experience should feel like this:**

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: ResponsiveContainer(
        child: ResponsivePadding(
          child: ResponsiveGrid(
            children: [
              AppCard(
                child: Text('Card 1'),
              ),
              AppCard(
                child: Text('Card 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

The developer should not need to manually configure responsive padding, card styling, grid columns, screen width detection, foldable handling, or platform-specific layout behavior for common use cases.

Everything should work intelligently by default while remaining configurable when necessary.


# Autonomous Execution Mode

You are authorized to inspect, modify, create, refactor, and test files within this existing Flutter repository.

Do not stop after creating a plan.

Execute the implementation in logical phases.

After each phase:

1. Run relevant formatting.
2. Run static analysis.
3. Run targeted tests.
4. Fix errors introduced by your changes.
5. Verify backward compatibility.

If a dependency is required:

* Check whether an existing dependency already provides the functionality.
* Prefer Flutter SDK APIs when sufficient.
* Add a third-party dependency only when justified.
* Verify compatibility with the project's Flutter and Dart SDK versions.

If physical foldable hardware is unavailable:

* Create testable abstractions and simulated display feature configurations.
* Use widget tests to validate hinge-aware behavior.
* Clearly document what was simulated versus physically verified.

Do not fabricate test results.

If a test cannot run, explain why and provide the exact command needed to run it.

Continue implementation until the definition of done is satisfied or a genuine technical blocker prevents progress.

Do not ask for confirmation before implementing routine architectural decisions that are already covered by this specification.
