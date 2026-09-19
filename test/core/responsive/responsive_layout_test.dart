import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/responsive/breakpoints.dart';
import 'package:quran_app/core/responsive/responsive_layout.dart';

void main() {
  group('ResponsiveLayout.columnsForWidth', () {
    test('phone width yields 2 columns with defaults', () {
      expect(ResponsiveLayout.columnsForWidth(400), 2);
    });

    test('narrow width yields a single column', () {
      expect(ResponsiveLayout.columnsForWidth(100), 1);
    });

    test('wide width caps at maxColumns', () {
      expect(ResponsiveLayout.columnsForWidth(2000, maxColumns: 4), 4);
    });

    test('respects custom minItemWidth and maxColumns', () {
      expect(
        ResponsiveLayout.columnsForWidth(
          800,
          minItemWidth: 200,
          maxColumns: 6,
          spacing: 16,
        ),
        3,
      );
    });
  });

  group('ResponsiveLayout.shouldUseTwoPane', () {
    test('compact never splits', () {
      expect(ResponsiveLayout.shouldUseTwoPane(400), isFalse);
    });

    test('expanded splits when both panes fit', () {
      expect(ResponsiveLayout.shouldUseTwoPane(1000), isTrue);
    });

    test('refuses split when second pane is too narrow', () {
      expect(
        ResponsiveLayout.shouldUseTwoPane(
          850,
          splitRatio: 0.4,
          minSecondPaneWidth: 600,
        ),
        isFalse,
      );
    });

    test('honors explicit breakpoint override', () {
      expect(
        ResponsiveLayout.shouldUseTwoPane(
          1000,
          breakpoint: AppBreakpoint.compact,
        ),
        isFalse,
      );
    });
  });

  group('ResponsiveLayout.maxContentWidth', () {
    test('grows with breakpoint', () {
      final widths = AppBreakpoint.values.map(ResponsiveLayout.maxContentWidth);
      final list = widths.toList();
      for (var i = 1; i < list.length; i++) {
        expect(list[i], greaterThanOrEqualTo(list[i - 1]));
      }
    });
  });
}
