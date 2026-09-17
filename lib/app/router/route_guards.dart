import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';

/// Central navigation guards and redirects.
///
/// Keeps redirect logic out of widgets and the router declaration.
abstract final class RouteGuards {
  /// Valid 1-based surah numbers (114 surahs).
  static const int minSurahNumber = 1;
  static const int maxSurahNumber = 114;

  /// Normalizes `quranapp://` deep links to paths and bounces invalid
  /// surah numbers back to the surah list. Returns `null` to allow.
  static String? redirect(BuildContext context, GoRouterState state) {
    final Uri uri = state.uri;
    if (uri.scheme == 'quranapp') {
      return '/${uri.host}${uri.path}';
    }
    final String? rawNumber = state.pathParameters['surahNumber'];
    if (rawNumber != null) {
      final int? surahNumber = int.tryParse(rawNumber);
      if (surahNumber == null ||
          surahNumber < minSurahNumber ||
          surahNumber > maxSurahNumber) {
        return RouteNames.surahs;
      }
    }
    return null;
  }
}
