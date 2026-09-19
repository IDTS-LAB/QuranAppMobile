import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/responsive/breakpoints.dart';

void main() {
  group('Breakpoints.breakpointOf', () {
    test('classifies compact windows (< 600)', () {
      expect(Breakpoints.breakpointOf(0), AppBreakpoint.compact);
      expect(Breakpoints.breakpointOf(359), AppBreakpoint.compact);
      expect(Breakpoints.breakpointOf(599.9), AppBreakpoint.compact);
    });

    test('classifies medium windows (600-839)', () {
      expect(Breakpoints.breakpointOf(600), AppBreakpoint.medium);
      expect(Breakpoints.breakpointOf(717), AppBreakpoint.medium);
      expect(Breakpoints.breakpointOf(839.9), AppBreakpoint.medium);
    });

    test('classifies expanded windows (840-1199)', () {
      expect(Breakpoints.breakpointOf(840), AppBreakpoint.expanded);
      expect(Breakpoints.breakpointOf(1024), AppBreakpoint.expanded);
      expect(Breakpoints.breakpointOf(1199.9), AppBreakpoint.expanded);
    });

    test('classifies large windows (1200-1599)', () {
      expect(Breakpoints.breakpointOf(1200), AppBreakpoint.large);
      expect(Breakpoints.breakpointOf(1440), AppBreakpoint.large);
      expect(Breakpoints.breakpointOf(1599.9), AppBreakpoint.large);
    });

    test('classifies extraLarge windows (>= 1600)', () {
      expect(Breakpoints.breakpointOf(1600), AppBreakpoint.extraLarge);
      expect(Breakpoints.breakpointOf(2560), AppBreakpoint.extraLarge);
    });

    test('supports custom config', () {
      const config = BreakpointConfig(
        compactMax: 500,
        mediumMax: 700,
        expandedMax: 900,
        largeMax: 1100,
      );
      expect(Breakpoints.breakpointOf(499, config), AppBreakpoint.compact);
      expect(Breakpoints.breakpointOf(500, config), AppBreakpoint.medium);
      expect(Breakpoints.breakpointOf(900, config), AppBreakpoint.large);
      expect(Breakpoints.breakpointOf(1100, config), AppBreakpoint.extraLarge);
    });
  });

  group('Breakpoints legacy helpers', () {
    test('isCompact matches < 600', () {
      expect(Breakpoints.isCompact(599), isTrue);
      expect(Breakpoints.isCompact(600), isFalse);
    });

    test('isAtLeast compares breakpoint order', () {
      expect(Breakpoints.isAtLeast(840, AppBreakpoint.expanded), isTrue);
      expect(Breakpoints.isAtLeast(839, AppBreakpoint.expanded), isFalse);
      expect(Breakpoints.isAtLeast(2000, AppBreakpoint.large), isTrue);
    });
  });

  group('AppBreakpointX', () {
    test('flags resolve correctly', () {
      expect(AppBreakpoint.compact.isCompact, isTrue);
      expect(AppBreakpoint.medium.isMedium, isTrue);
      expect(AppBreakpoint.compact.isAtLeastExpanded, isFalse);
      expect(AppBreakpoint.expanded.isAtLeastExpanded, isTrue);
      expect(AppBreakpoint.large.isAtLeastLarge, isTrue);
      expect(AppBreakpoint.expanded.isAtLeastLarge, isFalse);
      expect(AppBreakpoint.compact.isSinglePane, isTrue);
      expect(AppBreakpoint.medium.isSinglePane, isFalse);
    });
  });
}
