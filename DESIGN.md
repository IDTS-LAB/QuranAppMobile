You are working on an existing Flutter application.

Your task is to implement the application's UI design system based on the supplied reference image.

The reference image is the SINGLE SOURCE OF TRUTH for the visual direction.

Design System:
NOBLE FOREST — PREMIUM QURANIC UI

Do not redesign it.
Do not replace it with generic Material 3.
Do not introduce a different color palette.
Do not invent a different visual style.

The result should feel like a calm, premium, modern Quran application.

============================================================
0. FIRST: INSPECT THE EXISTING PROJECT
============================================================

Before writing code, inspect the existing Flutter project.

Determine:

- Flutter version
- Dart version
- Existing project architecture
- Existing theme implementation
- Existing fonts
- pubspec.yaml
- Existing localization
- Existing RTL support
- Existing reusable widgets
- Existing navigation
- Existing state management
- Existing design tokens

Do not rewrite unrelated application code.

Extend the existing architecture where possible.

If an existing design-system/theme structure already exists, improve it instead of creating duplicate systems.

============================================================
1. DESIGN PHILOSOPHY
============================================================

The design language is:

- Calm & Spiritual
- Respectful Focus
- Trustworthy & Private
- Premium Modernity

These principles are mandatory.

--------------------------------------------
CALM & SPIRITUAL
--------------------------------------------

Prioritize:

- generous whitespace
- natural colors
- soft surfaces
- comfortable typography
- quiet visual hierarchy
- minimal visual noise

The application should feel meditative.

Avoid:

- excessive animation
- excessive decoration
- visual clutter
- aggressive colors

--------------------------------------------
RESPECTFUL FOCUS
--------------------------------------------

The Quranic text is the visual anchor.

UI must never compete with Quran content.

Therefore:

- Quran text should receive strong typographic hierarchy.
- Controls should remain visually secondary.
- Decorative elements should be subtle.
- Primary actions should be clear but not visually aggressive.

--------------------------------------------
TRUSTWORTHY & PRIVATE
--------------------------------------------

The product should communicate trust.

Design direction:

- no social-feed aesthetic
- no unnecessary gamification
- no excessive tracking-style dashboards
- no noisy notification indicators
- no unnecessary decorative UI

Prefer:

- local-first visual language
- clear states
- transparent interactions
- restrained information density

--------------------------------------------
PREMIUM MODERNITY
--------------------------------------------

Premium quality should come from:

- typography
- spacing
- proportions
- subtle shadows
- refined borders
- restrained colors
- consistent components

NOT from:

- gradients
- glassmorphism
- glowing effects
- excessive shadows
- decorative animations

============================================================
2. COLOR SYSTEM
============================================================

Create centralized design tokens.

Primary brand color:

Noble Green
#1B4B32

Secondary brand color:

Noble Gold
#C1A461

Application background:

Canvas Background
#FDFCF8

Primary text:

Text Primary
#2D3436

Supporting colors should be derived carefully from the reference.

Define:

AppColors.nobleGreen
AppColors.nobleGold
AppColors.canvas
AppColors.textPrimary
AppColors.textSecondary
AppColors.surface
AppColors.border
AppColors.disabled
AppColors.success
AppColors.error
AppColors.warning

Suggested supporting values:

Text Secondary:
#6F7885

Surface:
#FFFFFF

Border:
#E5E8E7

Muted Surface:
#F4F5F3

Disabled:
#AEB5B2

Success:
#2E7D5B

Error:
#B94A48

Warning:
#C1A461

IMPORTANT:

Never hardcode these colors inside widgets.

BAD:

Color(0xFF1B4B32)

GOOD:

AppColors.nobleGreen

============================================================
3. VISUAL COLOR USAGE
============================================================

Noble Green is the dominant brand color.

Use it for:

- primary actions
- active navigation
- important headings
- Quran-related controls
- selected states
- primary surfaces

Noble Gold is an accent.

Use it for:

- premium
- progress highlights
- secondary emphasis
- audio/play actions
- selected decorative elements
- premium indicators

Canvas Background should dominate the application.

The interface should NOT look like a dark green application.

Green should be used intentionally.

Gold should remain an accent rather than a second primary color.

============================================================
4. BRAND TYPOGRAPHY
============================================================

The reference uses:

Latin Interface:
IBM Plex Sans

Arabic Script:
IBM Plex Sans Arabic

Use these fonts consistently.

Prefer local font assets if the project already contains them.

Otherwise evaluate whether google_fonts is appropriate.

Do not introduce multiple unrelated font families.

--------------------------------------------
LATIN
--------------------------------------------

IBM Plex Sans should be used for:

- navigation
- buttons
- labels
- headings
- settings
- metadata
- descriptions
- interface text

--------------------------------------------
ARABIC UI
--------------------------------------------

IBM Plex Sans Arabic should be used for:

- Arabic interface labels
- Arabic settings
- Arabic navigation
- Arabic UI descriptions

--------------------------------------------
QURAN TEXT
--------------------------------------------

IMPORTANT:

Do NOT assume IBM Plex Sans Arabic is the final Quran verse font.

Create a separate abstraction:

QuranText
QuranTextStyle

The Quran font must be replaceable independently.

Architecture:

QuranText
    ↓
QuranTextStyle
    ↓
Dedicated Quran font

This allows future Uthmani/Mushaf fonts to be introduced without modifying the UI system.

============================================================
5. TYPOGRAPHY SCALE
============================================================

Create a centralized typography system.

At minimum:

displayLarge
displayMedium
displaySmall

headlineLarge
headlineMedium
headlineSmall

titleLarge
titleMedium
titleSmall

bodyLarge
bodyMedium
bodySmall

labelLarge
labelMedium
labelSmall

Also create:

arabicLarge
arabicMedium
arabicSmall

quranLarge
quranMedium
quranSmall

Use:

400 Regular
500 Medium
600 SemiBold
700 Bold

Avoid excessive use of 700.

The reference uses typography itself as a major visual element.

Headings should feel strong but elegant.

Body text should feel quiet and readable.

============================================================
6. SECTION LABELS
============================================================

The reference uses small gold uppercase section labels.

Examples:

BRAND PRINCIPLES
LATIN INTERFACE
ARABIC SCRIPT
CARDS & CONTAINERS
INTERACTION
PROGRESS & INDICATORS

Create:

AppSectionLabel

Characteristics:

- Noble Gold
- uppercase
- SemiBold
- small size
- increased letter spacing
- compact line height

Example:

AppSectionLabel(
  'BRAND PRINCIPLES',
)

Do not manually reproduce this styling in every screen.

============================================================
7. SPACING SYSTEM
============================================================

The reference has generous spacing.

Base unit:

8px

Create:

AppSpacing.xs = 4
AppSpacing.sm = 8
AppSpacing.md = 16
AppSpacing.lg = 24
AppSpacing.xl = 32
AppSpacing.xxl = 40
AppSpacing.xxxl = 48
AppSpacing.section = 64

Use the spacing system everywhere.

Avoid arbitrary values unless a visual requirement genuinely requires them.

The design should breathe.

============================================================
8. BORDER RADIUS
============================================================

Create centralized radius tokens.

small:
8

medium:
16

large:
24

extraLarge:
32

pill:
999

Reference:

Primary Card:
32px

Surface Container:
16px

Buttons:
16px

Badges:
pill

Floating buttons:
circle

============================================================
9. BORDERS
============================================================

Borders are subtle.

Default:

AppColors.border

approximately:

#E5E8E7

Use 1px borders.

Do not create strong outlines.

Cards and secondary controls should use subtle borders rather than heavy elevation.

============================================================
10. SHADOWS
============================================================

The reference demonstrates very subtle shadows.

Create:

AppShadows.none
AppShadows.sm
AppShadows.md
AppShadows.xl

Shadow SM:

Purpose:
Subtle Depth

Characteristics:

- low opacity
- low blur
- small vertical offset

Shadow XL:

Purpose:
Floating UI

Characteristics:

- soft
- diffused
- larger blur
- low opacity

Never use heavy black shadows.

Avoid Material default elevation if it creates a visually inconsistent result.

============================================================
11. CORE COMPONENTS
============================================================

Create reusable components.

Suggested structure:

lib/core/
  theme/
    app_colors.dart
    app_typography.dart
    app_spacing.dart
    app_radius.dart
    app_shadows.dart
    app_theme.dart

  design_system/
    design_system_screen.dart

  widgets/
    buttons/
    cards/
    badges/
    indicators/
    navigation/
    surfaces/
    typography/
    inputs/

============================================================
12. PRIMARY CARD
============================================================

Create:

AppCard

Reference:

- white surface
- subtle border
- very subtle shadow
- approximately 32px radius
- generous padding

Visual example:

Primary Card

2rem / 32px rounded corners

API:

AppCard(
  child: ...
)

Support:

- child
- padding
- margin
- borderRadius
- backgroundColor
- border
- shadow
- onTap

Do not create separate card implementations for each feature.

============================================================
13. SURFACE CONTAINER
============================================================

Create:

AppSurface

Reference:

- Noble Green background
- white/light content
- 16px rounded corners
- compact but comfortable padding

Example:

AppSurface(
  child: ...
)

Use this for emphasized content areas.

============================================================
14. PRIMARY BUTTON
============================================================

Create:

AppPrimaryButton

Reference:

- Noble Green background
- white text
- 16px radius
- approximately 52–56px height
- SemiBold label
- comfortable horizontal padding

Example:

AppPrimaryButton(
  label: 'Continue',
  onPressed: ...
)

States:

- default
- pressed
- disabled
- loading

Optional:

- leadingIcon
- trailingIcon
- fullWidth
- width
- height

Do not add unnecessary shadows.

============================================================
15. SECONDARY BUTTON
============================================================

Create:

AppSecondaryButton

Reference:

- light/white background
- Noble Green text
- subtle border
- 16px radius
- same visual height as primary

States:

- default
- pressed
- disabled
- loading

============================================================
16. ICON BUTTON
============================================================

Create:

AppIconButton

Use a consistent icon family.

Recommended:

Material Symbols Rounded

Sizes:

16
20
24
32

Touch target:

minimum 48x48

Support:

- selected
- disabled
- tooltip
- semanticLabel

Never use emojis as interface icons.

============================================================
17. FLOATING ACTION BUTTON
============================================================

Create:

AppFloatingActionButton

Reference:

- Noble Gold
- white icon
- circular
- subtle shadow

Typical use:

- Play
- Resume
- Audio
- Quran action

The reference specifically demonstrates a gold circular play button.

============================================================
18. BADGES
============================================================

Create:

AppBadge

Variants:

BadgeVariant.tag
BadgeVariant.premium
BadgeVariant.success
BadgeVariant.neutral

Reference:

TAG LABEL:

- pale green background
- green text
- pill shape

PREMIUM:

- pale gold background
- gold/dark gold text
- pill shape

Badges should remain visually small.

============================================================
19. PROGRESS INDICATORS
============================================================

Create:

AppProgressBar

Reference:

- thin horizontal track
- light neutral track
- rounded ends
- green or gold progress

Example:

AppProgressBar(
  value: 0.65,
)

Also create:

AppCircularProgress

Use Noble Green by default.

============================================================
20. NAVIGATION
============================================================

Create a reusable navigation system consistent with the reference.

Active navigation:

- Noble Green

Inactive navigation:

- muted gray

Avoid heavy navigation containers.

Navigation should feel lightweight.

The reference demonstrates simple icon-based navigation indicators.

Use consistent icon sizing and spacing.

============================================================
21. DIVIDERS
============================================================

Create:

AppDivider

Characteristics:

- 1px
- subtle border color
- low visual prominence

Use dividers only where they improve hierarchy.

============================================================
22. QURAN TEXT COMPONENT
============================================================

Create:

QuranText

Example:

QuranText(
  text: verse.text,
)

Properties:

- text
- style
- fontSize
- lineHeight
- textAlign
- textDirection
- color
- maxLines
- overflow

Support:

- RTL
- Arabic shaping
- dynamic font size
- dynamic line height

Quran text must remain visually dominant over UI controls.

============================================================
23. RTL
============================================================

Arabic support is mandatory.

Use Flutter localization and directionality correctly.

Support:

- RTL screens
- Arabic navigation
- Arabic UI
- Quran text
- mixed Arabic/Latin content

Do not manually position elements for RTL.

Prefer:

Directionality
Localizations
AlignmentDirectional
EdgeInsetsDirectional
BorderRadiusDirectional

over left/right-specific implementations.

============================================================
24. ACCESSIBILITY
============================================================

Every interactive component must support:

- semantic labels
- minimum 48x48 touch targets
- text scaling
- focus states
- screen reader support
- sufficient contrast
- disabled states

Do not communicate state using color alone.

============================================================
25. RESPONSIVE LAYOUT
============================================================

The reference is a wide design-system presentation, but the actual Flutter application must be mobile-first.

Support:

- small phones
- large phones
- tablets

Never assume a fixed screen width.

Use:

LayoutBuilder
MediaQuery
Flexible
Expanded
ConstrainedBox

Avoid overflow.

============================================================
26. DARK MODE
============================================================

The reference is primarily light mode.

Implement the Noble Forest system with LIGHT mode as the primary target.

Do not create a dark theme that simply inverts the colors.

If dark mode already exists in the project:

preserve it.

Refactor it so the same semantic design tokens can support both modes.

Dark mode should be implemented separately rather than:

background = black
text = white

============================================================
27. FLUTTER THEME
============================================================

Create:

AppTheme.light()

and, if needed:

AppTheme.dark()

Configure:

ThemeData
ColorScheme
TextTheme
Scaffold
AppBar
CardTheme
ElevatedButtonTheme
OutlinedButtonTheme
TextButtonTheme
InputDecorationTheme
NavigationBarTheme
FloatingActionButtonTheme
ProgressIndicatorTheme
DividerTheme
DialogTheme

Do not blindly use default Material 3 styling.

The design system must control the appearance.

============================================================
28. DESIGN TOKENS
============================================================

All visual constants must be centralized.

Example:

class AppColors {
  static const nobleGreen = Color(0xFF1B4B32);
  static const nobleGold = Color(0xFFC1A461);
  static const canvas = Color(0xFFFDFCF8);
  static const textPrimary = Color(0xFF2D3436);
}

Example:

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 40.0;
  static const xxxl = 48.0;
  static const section = 64.0;
}

Example:

class AppRadius {
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const pill = 999.0;
}

============================================================
29. DESIGN SYSTEM SHOWCASE
============================================================

Create a development-only:

DesignSystemScreen

It should visually demonstrate the complete Noble Forest system.

Structure it similarly to the supplied reference.

------------------------------------------------------------
HEADER
------------------------------------------------------------

Design System

NOBLE FOREST — PREMIUM QURANIC UI

------------------------------------------------------------
BRAND PRINCIPLES
------------------------------------------------------------

Display four principle cards/columns:

1. Calm & Spiritual

"Prioritizing white space and natural tones to foster a meditative environment."

2. Respectful Focus

"The Quranic text is the anchor. UI never competes with scripture."

3. Trustworthy & Private

"No social feeds or generic tracking. Data is local and private by default."

4. Premium Modernity

"Subtle shadows and refined typography instead of flashy decorative elements."

------------------------------------------------------------
COLOR PALETTE
------------------------------------------------------------

Show:

Noble Green
#1B4B32

Noble Gold
#C1A461

Canvas Background
#FDFCF8

Text Primary
#2D3436

Each color should include:

- color swatch
- name
- hex value

------------------------------------------------------------
TYPOGRAPHY
------------------------------------------------------------

Show:

LATIN INTERFACE

IBM Plex Sans

Clean, modern, and highly legible for interface elements, settings, and navigational labels.

Then:

ARABIC SCRIPT

IBM Plex Sans Arabic

Elegant and balanced Arabic typography optimized for mobile screen reading.

------------------------------------------------------------
CORE COMPONENTS
------------------------------------------------------------

Create sections:

CARDS & CONTAINERS

Show:

Primary Card

2rem / 32px rounded corners

Surface Container

1rem / 16px rounded corners

INTERACTION

Show:

Primary Button

Secondary Button

Icon Button

Floating Action Button

PROGRESS & INDICATORS

Show:

Progress bar

TAG LABEL

PREMIUM

Navigation icons

------------------------------------------------------------
SPACING & SHADOWS
------------------------------------------------------------

Show:

Base Unit: 8px

Shadow SM — Subtle Depth

Shadow XL — Floating UI

Visually demonstrate each token.

============================================================
30. DESIGN SYSTEM SHOWCASE RESPONSIVENESS
============================================================

The DesignSystemScreen itself should be responsive.

Desktop/tablet:

Use multi-column layout similar to the reference.

Mobile:

Stack sections vertically.

Do not simply shrink the desktop layout.

Use:

LayoutBuilder

to change layout based on available width.

============================================================
31. FILE STRUCTURE
============================================================

Prefer:

lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   ├── app_radius.dart
│   │   ├── app_shadows.dart
│   │   └── app_theme.dart
│   │
│   ├── design_system/
│   │   └── design_system_screen.dart
│   │
│   └── widgets/
│       ├── buttons/
│       │   ├── app_primary_button.dart
│       │   ├── app_secondary_button.dart
│       │   └── app_icon_button.dart
│       │
│       ├── cards/
│       │   ├── app_card.dart
│       │   └── app_surface.dart
│       │
│       ├── indicators/
│       │   ├── app_progress_bar.dart
│       │   └── app_badge.dart
│       │
│       ├── navigation/
│       │   └── app_navigation.dart
│       │
│       └── typography/
│           ├── app_text.dart
│           └── quran_text.dart
│
├── features/
│   ├── home/
│   ├── quran/
│   ├── bookmarks/
│   ├── audio/
│   └── settings/
│
├── data/
│
└── domain/

Adapt this structure to the existing project instead of blindly applying it.

============================================================
32. CODE QUALITY
============================================================

Follow modern Flutter practices.

Requirements:

- null safety
- const constructors wherever possible
- immutable widgets
- small composable widgets
- no unnecessary rebuilds
- no duplicated styles
- no magic numbers
- no magic colors
- no unnecessary dependencies
- clean APIs
- meaningful names
- documentation for public design-system APIs

Use Theme.of(context) where semantic theme values make sense.

Use design tokens for fixed visual specifications.

============================================================
33. DO NOT DO THESE THINGS
============================================================

DO NOT:

- redesign the colors
- replace green with another green
- replace gold with another gold
- use gradients
- use glassmorphism
- use neon colors
- add excessive animations
- use excessive shadows
- use emojis for icons
- use random icon families
- hardcode colors in feature widgets
- duplicate button styles
- duplicate card styles
- use arbitrary spacing everywhere
- make the UI look like a generic Material app
- make the UI look like a social media app
- make the Quran text visually secondary
- add unnecessary decorative Islamic patterns

============================================================
34. VALIDATION
============================================================

After implementation:

Run:

flutter analyze

Then run relevant tests.

Then run the application.

Inspect:

DesignSystemScreen

Verify:

- colors
- spacing
- typography
- radius
- borders
- shadows
- buttons
- cards
- badges
- progress indicators
- iconography
- RTL
- accessibility
- responsive behavior

Compare the implementation against the supplied reference image.

Fix visual inconsistencies.

============================================================
35. ACCEPTANCE CRITERIA
============================================================

The implementation is complete when:

[ ] Noble Forest color palette exists.
[ ] Brand principles are represented.
[ ] 8px spacing system exists.
[ ] Radius tokens exist.
[ ] Shadow tokens exist.
[ ] IBM Plex Sans is used for Latin UI.
[ ] IBM Plex Sans Arabic is used for Arabic UI.
[ ] Quran typography is separated from UI typography.
[ ] AppTheme is centralized.
[ ] Primary Card exists.
[ ] Surface Container exists.
[ ] Primary Button exists.
[ ] Secondary Button exists.
[ ] Icon Button exists.
[ ] Floating Action Button exists.
[ ] Progress Bar exists.
[ ] Badge exists.
[ ] Navigation components exist.
[ ] QuranText exists.
[ ] RTL support exists.
[ ] Accessibility requirements are respected.
[ ] Responsive layouts are implemented.
[ ] DesignSystemScreen exists.
[ ] DesignSystemScreen resembles the supplied reference.
[ ] Feature widgets do not hardcode design tokens.
[ ] No unnecessary dependencies were introduced.
[ ] Existing application behavior is preserved.
[ ] flutter analyze passes.

============================================================
FINAL RULE
============================================================

The supplied Noble Forest Design System image is the visual source of truth.

When implementation details are not explicitly specified:

choose the simplest solution that preserves:

CALM
SPIRITUAL
RESPECTFUL
PRIVATE
PREMIUM
MODERN

The Quran is the product's visual and emotional anchor.

The UI should support the Quran experience, never compete with it.