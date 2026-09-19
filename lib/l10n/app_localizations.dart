import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get appTitle;

  /// Bottom/rail navigation destination: home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom/rail navigation destination: Quran reader.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuran;

  /// Bottom/rail navigation destination: memorization tracker.
  ///
  /// In en, this message translates to:
  /// **'Hifz'**
  String get navHifz;

  /// Bottom/rail navigation destination: audio.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get navListen;

  /// Bottom/rail navigation destination: more/settings.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// Home header greeting line.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum,'**
  String get homeGreeting;

  /// Demo date line until real Hijri/Gregorian formatting lands.
  ///
  /// In en, this message translates to:
  /// **'Monday, 23 Oct • 8 Rabi\' al-Thani'**
  String get homeDate;

  /// Home grid menu item title.
  ///
  /// In en, this message translates to:
  /// **'Read Quran'**
  String get menuReadTitle;

  /// Home grid menu item subtitle.
  ///
  /// In en, this message translates to:
  /// **'Read & Explore'**
  String get menuReadSubtitle;

  /// Home grid menu item title.
  ///
  /// In en, this message translates to:
  /// **'Audio Hub'**
  String get menuListenTitle;

  /// Home grid menu item subtitle.
  ///
  /// In en, this message translates to:
  /// **'Recitation'**
  String get menuListenSubtitle;

  /// Home grid menu item title.
  ///
  /// In en, this message translates to:
  /// **'Memorization'**
  String get menuHifzTitle;

  /// Home grid menu item subtitle.
  ///
  /// In en, this message translates to:
  /// **'Hifz Tracker'**
  String get menuHifzSubtitle;

  /// Home grid menu item title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get menuSearchTitle;

  /// Home grid menu item subtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get menuSearchSubtitle;

  /// Home grid menu section header.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get homeShortcuts;

  /// Home section header.
  ///
  /// In en, this message translates to:
  /// **'Recently Read'**
  String get homeRecentlyRead;

  /// Home section action.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeSeeAll;

  /// Progress card badge.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get progressBadge;

  /// Demo surah name until reading position drives it.
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah'**
  String get progressSurahName;

  /// Demo reading position line.
  ///
  /// In en, this message translates to:
  /// **'Ayah {ayah} • Juz {juz}'**
  String progressAyahJuz(String ayah, String juz);

  /// Progress card CTA.
  ///
  /// In en, this message translates to:
  /// **'Read Now'**
  String get progressReadNow;

  /// Goal card title.
  ///
  /// In en, this message translates to:
  /// **'Daily Quran Goal'**
  String get goalTitle;

  /// Demo goal progress until real goal data lands.
  ///
  /// In en, this message translates to:
  /// **'8 of 10 pages completed'**
  String get goalProgress;

  /// Demo streak until real streak data lands.
  ///
  /// In en, this message translates to:
  /// **'12 Day streak'**
  String get goalStreak;

  /// Demo recent-read surah until history lands.
  ///
  /// In en, this message translates to:
  /// **'Al-Kahf'**
  String get recentSurahName;

  /// Demo recent-read detail until history lands.
  ///
  /// In en, this message translates to:
  /// **'Ayah 10 • Juz 15'**
  String get recentDetail;

  /// Surah list app bar title.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahsTitle;

  /// Surah list empty state.
  ///
  /// In en, this message translates to:
  /// **'No surahs found'**
  String get surahsEmpty;

  /// Surah detail app bar title.
  ///
  /// In en, this message translates to:
  /// **'Surah {number}'**
  String surahTitle(int number);

  /// Surah detail empty state.
  ///
  /// In en, this message translates to:
  /// **'No ayahs found'**
  String get surahEmpty;

  /// Surah card subtitle line.
  ///
  /// In en, this message translates to:
  /// **'{meaning} · {count} ayahs'**
  String surahListSubtitle(String meaning, int count);

  /// Screen-reader label for a surah card.
  ///
  /// In en, this message translates to:
  /// **'{name}, {meaning}, {count} ayahs'**
  String surahCardSemantics(String name, String meaning, int count);

  /// Search page app bar title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// Search field hint and initial empty state.
  ///
  /// In en, this message translates to:
  /// **'Search the Quran'**
  String get searchHint;

  /// Search hint for short queries.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 characters'**
  String get searchTooShort;

  /// Search empty-results state.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searchNoResults;

  /// Bookmarks page app bar title.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksTitle;

  /// Bookmarks empty state.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get bookmarksEmpty;

  /// Bookmark list row title.
  ///
  /// In en, this message translates to:
  /// **'Surah {surah} · Ayah {ayah}'**
  String bookmarkRow(int surah, int ayah);

  /// Bookmark row delete tooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove bookmark'**
  String get bookmarkRemoveRowTooltip;

  /// Ayah tile footer label.
  ///
  /// In en, this message translates to:
  /// **'Ayah {number}'**
  String ayahLabel(int number);

  /// Bookmark action tooltip.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmarkAdd;

  /// Remove-bookmark action tooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove bookmark'**
  String get bookmarkRemove;

  /// Resume banner title and screen-reader label.
  ///
  /// In en, this message translates to:
  /// **'Resume Surah {surah} · Ayah {ayah}'**
  String resumeTitle(int surah, int ayah);

  /// Shared retry button label.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// Settings page app bar title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings language section title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Settings language helper text.
  ///
  /// In en, this message translates to:
  /// **'Applies immediately and is remembered.'**
  String get settingsLanguageSubtitle;

  /// Follow-device-language option.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsSystemDefault;

  /// English language display name.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageNameEnglish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
