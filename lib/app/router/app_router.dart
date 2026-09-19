import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_app/features/home/presentation/pages/home_page.dart';

import 'package:quran_app/features/quran/presentation/pages/bookmarks_page.dart';
import 'package:quran_app/features/quran/presentation/pages/search_page.dart';
import 'package:quran_app/features/quran/presentation/pages/surah_detail_page.dart';
import 'package:quran_app/features/quran/presentation/pages/surah_list_page.dart';
import 'package:quran_app/features/settings/presentation/pages/settings_page.dart';

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
      initialLocation: RouteNames.home,
      redirect: RouteGuards.redirect,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              AdaptiveScaffold(navigationShell: navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.home,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const HomePage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) => FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.surahs,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const SurahListPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) => FadeTransition(opacity: animation, child: child),
                  ),
                  routes: <RouteBase>[
                    GoRoute(
                      path: ':surahNumber',
                      pageBuilder: (context, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: SurahDetailPage(
                          surahNumber:
                              int.tryParse(
                                state.pathParameters['surahNumber'] ?? '1',
                              ) ??
                              1,
                        ),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) => FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.search,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const SearchPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) => FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.bookmarks,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const BookmarksPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) => FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.more,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: const SettingsPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) => FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
