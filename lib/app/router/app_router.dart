import 'package:go_router/go_router.dart';

import '../../../features/quran/presentation/pages/bookmarks_page.dart';
import '../../../features/quran/presentation/pages/search_page.dart';
import '../../../features/quran/presentation/pages/surah_detail_page.dart';
import '../../../features/quran/presentation/pages/surah_list_page.dart';
import 'adaptive_scaffold.dart';
import 'route_guards.dart';
import 'route_names.dart';

/// Central router: `StatefulShellRoute.indexedStack` with surahs / search /
/// bookmarks branches; surah detail is nested under `/surahs/:surahNumber`.
///
/// Custom-scheme deep links such as `quranapp://surahs/2` are normalized to
/// paths by [RouteGuards.redirect] at the route level. (Android
/// intent-filter / iOS associated-domain wiring is a follow-up.)
abstract final class AppRouter {
  static GoRouter create() {
    return GoRouter(
      initialLocation: RouteNames.surahs,
      redirect: RouteGuards.redirect,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              AdaptiveScaffold(navigationShell: navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.surahs,
                  builder: (context, state) => const SurahListPage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: ':surahNumber',
                      builder: (context, state) {
                        final String raw =
                            state.pathParameters['surahNumber'] ?? '1';
                        return SurahDetailPage(
                          surahNumber: int.tryParse(raw) ?? 1,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.search,
                  builder: (context, state) => const SearchPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.bookmarks,
                  builder: (context, state) => const BookmarksPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
