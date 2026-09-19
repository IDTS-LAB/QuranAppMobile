// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Quran';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Quran';

  @override
  String get navHifz => 'Hifz';

  @override
  String get navListen => 'Listen';

  @override
  String get navMore => 'More';

  @override
  String get homeGreeting => 'Assalamu Alaikum,';

  @override
  String get homeDate => 'Monday, 23 Oct • 8 Rabi\' al-Thani';

  @override
  String get menuReadTitle => 'Read Quran';

  @override
  String get menuReadSubtitle => 'Read & Explore';

  @override
  String get menuListenTitle => 'Audio Hub';

  @override
  String get menuListenSubtitle => 'Recitation';

  @override
  String get menuHifzTitle => 'Memorization';

  @override
  String get menuHifzSubtitle => 'Hifz Tracker';

  @override
  String get menuSearchTitle => 'Search';

  @override
  String get menuSearchSubtitle => 'Explore';

  @override
  String get homeShortcuts => 'Shortcuts';

  @override
  String get homeRecentlyRead => 'Recently Read';

  @override
  String get homeSeeAll => 'See All';

  @override
  String get progressBadge => 'Continue Reading';

  @override
  String get progressSurahName => 'Al-Baqarah';

  @override
  String progressAyahJuz(String ayah, String juz) {
    return 'Ayah $ayah • Juz $juz';
  }

  @override
  String get progressReadNow => 'Read Now';

  @override
  String get goalTitle => 'Daily Quran Goal';

  @override
  String get goalProgress => '8 of 10 pages completed';

  @override
  String get goalStreak => '12 Day streak';

  @override
  String get recentSurahName => 'Al-Kahf';

  @override
  String get recentDetail => 'Ayah 10 • Juz 15';

  @override
  String get surahsTitle => 'Surahs';

  @override
  String get surahsEmpty => 'No surahs found';

  @override
  String surahTitle(int number) {
    return 'Surah $number';
  }

  @override
  String get surahEmpty => 'No ayahs found';

  @override
  String surahListSubtitle(String meaning, int count) {
    return '$meaning · $count ayahs';
  }

  @override
  String surahCardSemantics(String name, String meaning, int count) {
    return '$name, $meaning, $count ayahs';
  }

  @override
  String get searchTitle => 'Search';

  @override
  String get searchHint => 'Search the Quran';

  @override
  String get searchTooShort => 'Type at least 2 characters';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get bookmarksTitle => 'Bookmarks';

  @override
  String get bookmarksEmpty => 'No bookmarks yet';

  @override
  String bookmarkRow(int surah, int ayah) {
    return 'Surah $surah · Ayah $ayah';
  }

  @override
  String get bookmarkRemoveRowTooltip => 'Remove bookmark';

  @override
  String ayahLabel(int number) {
    return 'Ayah $number';
  }

  @override
  String get bookmarkAdd => 'Bookmark';

  @override
  String get bookmarkRemove => 'Remove bookmark';

  @override
  String resumeTitle(int surah, int ayah) {
    return 'Resume Surah $surah · Ayah $ayah';
  }

  @override
  String get retryButton => 'Retry';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle =>
      'Applies immediately and is remembered.';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get languageNameEnglish => 'English';
}
