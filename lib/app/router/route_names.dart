/// Central route definitions for the Quran reader.
///
/// Widgets must navigate through these helpers or the router branches —
/// never with hard-coded `context.go('...')` strings.
abstract final class RouteNames {
  static const String home = '/';
  static const String surahs = '/surahs';
  static const String search = '/search';
  static const String bookmarks = '/bookmarks';
  static const String more = '/more';
  static String surahDetail(int surahNumber) => '$surahs/$surahNumber';

  /// Maps a [location] to its shell branch index:
  /// 0 = surahs (including surah detail), 1 = search, 2 = bookmarks.
  ///
  /// Unknown locations fall back to the surahs branch.
  static int locationToIndex(String location) {
    if (location.startsWith(search)) {
      return 1;
    }
    if (location.startsWith(bookmarks)) {
      return 2;
    }
    return 0;
  }
}
