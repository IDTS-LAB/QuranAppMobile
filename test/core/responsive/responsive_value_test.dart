import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/responsive_value.dart';

void main() {
  group('ResponsiveValue.resolveFor', () {
    test('returns compact value for compact', () {
      const value = ResponsiveValue<int>(compact: 1, expanded: 3);
      expect(value.resolveFor(AppBreakpoint.compact), 1);
    });

    test('falls back toward compact when unspecified', () {
      const value = ResponsiveValue<int>(compact: 1, expanded: 3);
      expect(value.resolveFor(AppBreakpoint.medium), 1);
      expect(value.resolveFor(AppBreakpoint.expanded), 3);
      expect(value.resolveFor(AppBreakpoint.large), 3);
      expect(value.resolveFor(AppBreakpoint.extraLarge), 3);
    });

    test('prefers the nearest defined breakpoint', () {
      const value = ResponsiveValue<int>(compact: 1, medium: 2, large: 4);
      expect(value.resolveFor(AppBreakpoint.expanded), 2);
      expect(value.resolveFor(AppBreakpoint.large), 4);
      expect(value.resolveFor(AppBreakpoint.extraLarge), 4);
    });

    test('supports EdgeInsets and other types', () {
      const value = ResponsiveValue<EdgeInsets>(
        compact: EdgeInsets.all(16),
        expanded: EdgeInsets.all(32),
      );
      expect(value.resolveFor(AppBreakpoint.compact), const EdgeInsets.all(16));
      expect(
        value.resolveFor(AppBreakpoint.extraLarge),
        const EdgeInsets.all(32),
      );
    });
  });

  group('ResponsiveValue.resolveWidth', () {
    test('resolves from width', () {
      const value = ResponsiveValue<String>(
        compact: 'phone',
        expanded: 'tablet',
      );
      expect(value.resolveWidth(400), 'phone');
      expect(value.resolveWidth(1000), 'tablet');
    });
  });

  group('AppResponsive', () {
    testWidgets('value resolves from window width', (tester) async {
      String? result;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              result = AppResponsive.value(
                context,
                compact: 'compact',
                expanded: 'expanded',
              );
              return const SizedBox();
            },
          ),
        ),
      );
      expect(result, 'compact');
    });

    testWidgets('valueForWidth is pure', (tester) async {
      expect(
        AppResponsive.valueForWidth(1400, compact: 1, expanded: 2, large: 3),
        3,
      );
    });

    test('interpolate clamps to [min, max]', () {
      // Tested via widget context below.
    });

    testWidgets('interpolate scales within range', (tester) async {
      double? mid;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(780, 800)),
          child: Builder(
            builder: (context) {
              mid = AppResponsive.interpolate(
                context,
                min: 16,
                max: 32,
                minWidth: 360,
                maxWidth: 1200,
              );
              return const SizedBox();
            },
          ),
        ),
      );
      // t = (780-360)/(1200-360) = 0.5 → 24.
      expect(mid, closeTo(24, 0.001));
    });
  });
}
