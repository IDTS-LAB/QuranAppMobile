import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_app/app/router/adaptive_scaffold.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/l10n/app_localizations.dart';

GoRouter _testRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            AdaptiveScaffold(navigationShell: shell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (context, state) => const Text('page'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Future<void> _pumpShellAtSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  final router = _testRouter();
  addTearDown(router.dispose);
  return tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

void main() {
  group('AdaptiveScaffold navigation background', () {
    testWidgets('compact bottom bar uses canvas, not tinted green', (
      tester,
    ) async {
      await _pumpShellAtSize(tester, const Size(400, 800));
      await tester.pumpAndSettle();
      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(bar.backgroundColor, AppColors.canvas);
    });

    testWidgets('medium rail uses canvas, not tinted green', (tester) async {
      await _pumpShellAtSize(tester, const Size(800, 800));
      await tester.pumpAndSettle();
      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.backgroundColor, AppColors.canvas);
    });

    testWidgets('large sidebar uses canvas, not tinted green', (tester) async {
      await _pumpShellAtSize(tester, const Size(1400, 900));
      await tester.pumpAndSettle();
      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.backgroundColor, AppColors.canvas);
      expect(rail.extended, isTrue);
    });
  });
}
