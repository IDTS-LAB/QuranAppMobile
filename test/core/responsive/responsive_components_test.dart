import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/widgets/layout/fold_aware_layout.dart';
import 'package:quran_app/core/widgets/layout/hinge_aware_two_pane.dart';
import 'package:quran_app/core/widgets/layout/responsive_container.dart';
import 'package:quran_app/core/widgets/layout/responsive_flex.dart';
import 'package:quran_app/core/widgets/layout/responsive_grid.dart';

/// Pumps [child] at a fixed test window size.
Future<void> pumpAtSize(WidgetTester tester, Widget child, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  return tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
}

void main() {
  group('ResponsiveContainer', () {
    testWidgets('passes through full width on compact', (tester) async {
      await pumpAtSize(
        tester,
        const ResponsiveContainer(child: Text('content')),
        const Size(400, 800),
      );
      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('constrains content on expanded', (tester) async {
      await pumpAtSize(
        tester,
        const ResponsiveContainer(child: Text('content')),
        const Size(1400, 900),
      );
      final constrained = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.text('content'),
              matching: find.byType(ConstrainedBox),
            )
            .first,
      );
      expect(constrained.constraints.maxWidth, 1200);
      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('honors maxWidth override', (tester) async {
      await pumpAtSize(
        tester,
        const ResponsiveContainer(maxWidth: 900, child: Text('content')),
        const Size(1400, 900),
      );
      final constrained = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.text('content'),
              matching: find.byType(ConstrainedBox),
            )
            .first,
      );
      expect(constrained.constraints.maxWidth, 900);
    });
  });

  group('ResponsiveGrid', () {
    testWidgets('uses 2 columns on compact phones', (tester) async {
      await pumpAtSize(
        tester,
        const ResponsiveGrid(
          shrinkWrap: true,
          children: [Text('a'), Text('b'), Text('c')],
        ),
        const Size(400, 800),
      );
      await tester.pump();
      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });

    testWidgets('adds columns on wide windows', (tester) async {
      await pumpAtSize(
        tester,
        const ResponsiveGrid(
          shrinkWrap: true,
          children: [Text('a'), Text('b'), Text('c'), Text('d')],
        ),
        const Size(1400, 900),
      );
      await tester.pump();
      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 4);
    });
  });

  group('ResponsiveFlex', () {
    testWidgets('vertical on compact, horizontal on expanded', (tester) async {
      Future<Type> directionAt(Size size) async {
        await pumpAtSize(
          tester,
          const ResponsiveFlex(children: [Text('a'), Text('b')]),
          size,
        );
        await tester.pump();
        if (find.byType(Row).evaluate().isNotEmpty) return Row;
        return Column;
      }

      expect(await directionAt(const Size(400, 800)), Column);
      expect(await directionAt(const Size(1000, 800)), Row);
    });
  });

  group('HingeAwareTwoPane', () {
    const panes = HingeAwareTwoPane(
      first: Text('first'),
      second: Text('second'),
    );

    testWidgets('single pane on compact widths', (tester) async {
      await pumpAtSize(tester, panes, const Size(400, 800));
      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsNothing);
    });

    testWidgets('two panes on expanded widths', (tester) async {
      await pumpAtSize(tester, panes, const Size(1000, 800));
      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsOneWidget);
    });

    testWidgets('forced single strategy stays single', (tester) async {
      await pumpAtSize(
        tester,
        const HingeAwareTwoPane(
          paneStrategy: PaneStrategy.single,
          first: Text('first'),
          second: Text('second'),
        ),
        const Size(1000, 800),
      );
      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsNothing);
    });
  });

  group('FoldAwareLayout', () {
    testWidgets('renders child without display features', (tester) async {
      await pumpAtSize(
        tester,
        const FoldAwareLayout(child: Text('content')),
        const Size(400, 800),
      );
      expect(find.text('content'), findsOneWidget);
    });
  });

  group('Breakpoints sanity', () {
    test('expanded starts at 840', () {
      expect(Breakpoints.breakpointOf(839), AppBreakpoint.medium);
      expect(Breakpoints.breakpointOf(840), AppBreakpoint.expanded);
    });
  });
}
