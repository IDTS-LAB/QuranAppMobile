/// Centralized elevation tokens.
///
/// Prefer these over ad-hoc `elevation:` values so cards, dialogs, and
/// sheets share consistent depth.
abstract final class AppElevation {
  /// Flat: cards on canvas (default card style).
  static const double level0 = 0;

  /// Subtle lift: raised cards, list tiles.
  static const double level1 = 1;

  /// Default floating: buttons, snack bars.
  static const double level2 = 3;

  /// Emphasized: FAB, prominent CTAs.
  static const double level3 = 6;

  /// Overlay: dialogs, bottom sheets, drawers.
  static const double level4 = 8;

  /// Highest: modals above overlays.
  static const double level5 = 12;
}
