/// Width breakpoints driving adaptive navigation and layout.
///
/// Compact (<600): bottom [NavigationBar], single column.
/// Medium (600-1024): [NavigationRail], wider content.
/// Expanded (>1024): sidebar + two-pane, multi-column content.
abstract final class Breakpoints {
  static const double compactMaxWidth = 600;
  static const double expandedMinWidth = 1024;

  static bool isCompact(double width) => width < compactMaxWidth;

  static bool isMedium(double width) =>
      width >= compactMaxWidth && width <= expandedMinWidth;

  static bool isExpanded(double width) => width > expandedMinWidth;
}
