import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_app/core/widgets/buttons/app_floating_action_button.dart';
import 'package:quran_app/core/widgets/buttons/app_icon_button.dart';
import 'package:quran_app/core/widgets/buttons/app_primary_button.dart';
import 'package:quran_app/core/widgets/buttons/app_secondary_button.dart';
import 'package:quran_app/core/widgets/empty/app_empty_view.dart';
import 'package:quran_app/core/widgets/error/app_error_view.dart';
import 'package:quran_app/core/widgets/indicators/app_badge.dart';
import 'package:quran_app/core/widgets/indicators/app_circular_progress.dart';
import 'package:quran_app/core/widgets/indicators/app_progress_bar.dart';
import 'package:quran_app/core/widgets/loading/app_loading.dart';
import 'package:quran_app/core/widgets/typography/app_section_label.dart';
import 'package:quran_app/features/home/presentation/widgets/goal_card.dart';
import 'package:quran_app/features/home/presentation/widgets/header.dart';
import 'package:quran_app/features/home/presentation/widgets/progress_card.dart';
import 'package:quran_app/features/home/presentation/widgets/recent_read_card.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/reading_position.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/presentation/widgets/ayah_tile.dart';
import 'package:quran_app/features/quran/presentation/widgets/resume_banner.dart';
import 'package:quran_app/features/quran/presentation/widgets/surah_card.dart';

const _phone = Size(320, 700);
const _tablet = Size(1024, 768);

Future<void> _pumpAtSize(WidgetTester tester, Widget child, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  return tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(home: Scaffold(body: child)),
    ),
  );
}

void _expectNoOverflow(WidgetTester tester) {
  expect(tester.takeException(), isNull, reason: 'Layout overflow detected');
}

const _surah = Surah(
  number: 18,
  arabicName: 'الكهف',
  englishName: 'Al-Kahf',
  englishMeaning: 'The Cave',
  revelationType: 'Meccan',
  ayahCount: 110,
);

const _ayah = Ayah(
  surahNumber: 18,
  numberInSurah: 10,
  arabicText: 'بِسْمِ اللَّهِ',
  translation: 'In the name of Allah',
);

void main() {
  group('SurahCard', () {
    testWidgets('renders, forwards taps, no overflow at 320px', (tester) async {
      var tapped = false;
      await _pumpAtSize(
        tester,
        SurahCard(surah: _surah, onTap: () => tapped = true),
        _phone,
      );
      expect(find.text('Al-Kahf'), findsOneWidget);
      expect(find.text('الكهف'), findsOneWidget);
      await tester.tap(find.byType(SurahCard));
      expect(tapped, isTrue);
      _expectNoOverflow(tester);
    });

    testWidgets('long names ellipsize instead of overflowing', (tester) async {
      const long = Surah(
        number: 2,
        arabicName: 'البقرة',
        englishName: 'Al-Baqarah With A Very Long Descriptive Suffix Name',
        englishMeaning: 'The Cow With An Extremely Long Meaning Description',
        revelationType: 'Medinan',
        ayahCount: 286,
      );
      await _pumpAtSize(tester, SurahCard(surah: long, onTap: () {}), _phone);
      _expectNoOverflow(tester);
    });
  });

  group('AyahTile', () {
    testWidgets('renders text + bookmark toggle', (tester) async {
      var bookmarked = false;
      await _pumpAtSize(
        tester,
        AyahTile(
          ayah: _ayah,
          bookmarked: false,
          onBookmark: () => bookmarked = true,
        ),
        _phone,
      );
      expect(find.text('بِسْمِ اللَّهِ'), findsOneWidget);
      expect(find.text('In the name of Allah'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.bookmark_outline));
      expect(bookmarked, isTrue);
      _expectNoOverflow(tester);
    });
  });

  group('ResumeBanner', () {
    testWidgets('renders position and forwards taps', (tester) async {
      var tapped = false;
      await _pumpAtSize(
        tester,
        ResumeBanner(
          position: ReadingPosition(
            surahNumber: 2,
            ayahNumber: 142,
            updatedAt: DateTime(2026, 1, 1),
          ),
          onTap: () => tapped = true,
        ),
        _phone,
      );
      expect(find.textContaining('Surah 2'), findsOneWidget);
      await tester.tap(find.byType(ResumeBanner));
      expect(tapped, isTrue);
      _expectNoOverflow(tester);
    });
  });

  group('Buttons', () {
    testWidgets('primary renders label, loading, disabled', (tester) async {
      await _pumpAtSize(
        tester,
        Column(
          children: [
            AppPrimaryButton(label: 'Read Now', onPressed: () {}),
            AppPrimaryButton(label: 'Loading', onPressed: () {}, loading: true),
            const AppPrimaryButton(label: 'Off', onPressed: null),
          ],
        ),
        _phone,
      );
      expect(find.text('Read Now'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('long labels ellipsize at 320px', (tester) async {
      await _pumpAtSize(
        tester,
        AppPrimaryButton(
          label: 'A Very Long Button Label That Must Not Overflow',
          leadingIcon: const FaIcon(FontAwesomeIcons.bookOpen),
          trailingIcon: const FaIcon(FontAwesomeIcons.arrowRight),
          onPressed: () {},
        ),
        _phone,
      );
      _expectNoOverflow(tester);
    });

    testWidgets('secondary fullWidth + icon button targets', (tester) async {
      await _pumpAtSize(
        tester,
        Column(
          children: [
            AppSecondaryButton(
              label: 'Secondary',
              fullWidth: true,
              onPressed: () {},
            ),
            AppIconButton(
              icon: const Icon(Icons.bookmark),
              tooltip: 'Bookmark',
              onPressed: () {},
            ),
          ],
        ),
        _phone,
      );
      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      expect(iconButton.constraints!.minWidth, greaterThanOrEqualTo(48));
      _expectNoOverflow(tester);
    });

    testWidgets('FAB exposes semantic label', (tester) async {
      await _pumpAtSize(
        tester,
        const AppFloatingActionButton(
          semanticLabel: 'Play recitation',
          child: Icon(Icons.play_arrow),
        ),
        _phone,
      );
      expect(find.bySemanticsLabel('Play recitation'), findsOneWidget);
      _expectNoOverflow(tester);
    });
  });

  group('Indicators & feedback', () {
    testWidgets('badge, progress, loading, error, empty render', (
      tester,
    ) async {
      await _pumpAtSize(
        tester,
        const SingleChildScrollView(
          child: Column(
            children: [
              AppBadge(label: 'Continue Reading'),
              AppProgressBar(value: 0.8),
              AppCircularProgress(value: 0.8, label: '80%', size: 70),
              AppLoading(label: 'Loading surahs'),
              AppEmptyView(message: 'Nothing here', icon: Icons.inbox),
              AppErrorView(
                message: 'Failed',
                onRetry: _noop,
                icon: Icons.error,
              ),
            ],
          ),
        ),
        _phone,
      );
      expect(find.text('CONTINUE READING'), findsOneWidget);
      expect(find.text('Loading surahs'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('progress exposes semantics values', (tester) async {
      await _pumpAtSize(
        tester,
        const Column(
          children: [
            AppProgressBar(value: 0.5, semanticsLabel: 'Reading progress'),
            AppCircularProgress(
              value: 0.5,
              label: '50%',
              size: 70,
              semanticsLabel: 'Goal progress',
            ),
          ],
        ),
        _phone,
      );
      expect(find.bySemanticsLabel('Reading progress'), findsOneWidget);
      expect(find.bySemanticsLabel('Goal progress'), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('error/empty constrain width on tablets', (tester) async {
      await _pumpAtSize(
        tester,
        const Column(
          children: [
            AppErrorView(message: 'Failed', onRetry: _noop),
            AppEmptyView(message: 'Empty'),
          ],
        ),
        _tablet,
      );
      _expectNoOverflow(tester);
    });
  });

  group('Section label', () {
    testWidgets('long RTL labels ellipsize', (tester) async {
      await _pumpAtSize(
        tester,
        const AppSectionLabel(
          'An Extremely Long Section Label That Should Ellipsize Gracefully',
        ),
        _phone,
      );
      _expectNoOverflow(tester);
    });
  });

  group('Home widgets', () {
    testWidgets('header, cards render at 320px without overflow', (
      tester,
    ) async {
      await _pumpAtSize(
        tester,
        const SingleChildScrollView(
          child: Column(
            children: [
              HomePageHeader(
                name: 'A Very Long User Name That Could Overflow',
                profilePhoto: null,
              ),
              HomePageProgressCard(),
              HomePageGoalCard(),
              HomePageRecentReadCard(),
            ],
          ),
        ),
        _phone,
      );
      expect(find.text('Al-Baqarah'), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('home widgets render on tablets', (tester) async {
      await _pumpAtSize(
        tester,
        const SingleChildScrollView(
          child: Column(
            children: [
              HomePageHeader(name: 'Ahmed', profilePhoto: null),
              HomePageProgressCard(),
              HomePageGoalCard(),
              HomePageRecentReadCard(),
            ],
          ),
        ),
        _tablet,
      );
      _expectNoOverflow(tester);
    });
  });
}

void _noop() {}
