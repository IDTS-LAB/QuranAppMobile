import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/bookmark.dart';
import 'package:quran_app/features/quran/domain/entities/reading_position.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';

final class FakeSurahRepository implements SurahRepository {
  FakeSurahRepository({this._fail = false});

  final bool _fail;
  int toggleCalls = 0;

  static const Surah surah = Surah(
    number: 1,
    arabicName: 'الفاتحة',
    englishName: 'Al-Fatiha',
    englishMeaning: 'The Opener',
    revelationType: 'Meccan',
    ayahCount: 7,
  );

  static const Ayah ayah = Ayah(
    surahNumber: 1,
    numberInSurah: 1,
    arabicText: 'بِسْمِ اللَّهِ',
  );

  @override
  Future<Result<List<Surah>>> getSurahs() async {
    if (_fail) {
      return const Result.failure(NetworkException('offline'));
    }
    return const Result.success([surah]);
  }

  @override
  Future<Result<List<Ayah>>> getSurahDetail(int surahNumber) async {
    if (_fail) {
      return const Result.failure(NetworkException('offline'));
    }
    return const Result.success([ayah]);
  }

  @override
  Future<Result<List<Ayah>>> search(String query) async =>
      const Result.success([ayah]);

  @override
  Future<Result<List<Bookmark>>> getBookmarks() async {
    if (_fail) {
      return const Result.failure(NetworkException('offline'));
    }
    return Result.success([
      Bookmark(
        surahNumber: 1,
        ayahNumber: 1,
        createdAt: DateTime.utc(2026, 1, 1),
      ),
    ]);
  }

  @override
  Future<Result<void>> toggleBookmark(int surahNumber, int ayahNumber) async {
    toggleCalls += 1;
    if (_fail) {
      return const Result.failure(NetworkException('offline'));
    }
    return const Result.success(null);
  }

  @override
  Future<Result<void>> saveReadingPosition(
    int surahNumber,
    int ayahNumber,
  ) async => const Result.success(null);

  @override
  Future<Result<ReadingPosition?>> getReadingPosition(int surahNumber) async =>
      const Result.success(null);

  @override
  Future<Result<void>> syncFromRemote() async =>
      const Result.success(null);
}

void main() {
  test('surah list controller loads from fake repo', () async {
    final container = ProviderContainer(
      overrides: [
        surahRepositoryProvider.overrideWithValue(FakeSurahRepository()),
      ],
    );
    addTearDown(container.dispose);
    final state = await container.read(surahListControllerProvider.future);
    expect(state.length, 1);
    expect(state.first.englishName, 'Al-Fatiha');
  });

  test('surah detail controller loads surah and ayahs', () async {
    final container = ProviderContainer(
      overrides: [
        surahRepositoryProvider.overrideWithValue(FakeSurahRepository()),
      ],
    );
    addTearDown(container.dispose);
    final view = await container.read(
      surahDetailControllerProvider(1).future,
    );
    expect(view.surah.number, 1);
    expect(view.ayahs.length, 1);
  });

  test('bookmarks controller loads and toggles', () async {
    final fake = FakeSurahRepository();
    final container = ProviderContainer(
      overrides: [surahRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    final initial = await container.read(bookmarksControllerProvider.future);
    expect(initial.length, 1);

    await container
        .read(bookmarksControllerProvider.notifier)
        .toggle(1, 2);
    expect(fake.toggleCalls, 1);
    final refreshed = await container.read(bookmarksControllerProvider.future);
    expect(refreshed.length, 1);
  });

  test('surah list maps Result.failure to AsyncError', () async {
    final container = ProviderContainer(
      overrides: [
        surahRepositoryProvider.overrideWithValue(
          FakeSurahRepository(fail: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    final sub = container.listen(surahListControllerProvider, (_, _) {});
    addTearDown(sub.close);
    await expectLater(
      container.read(surahListControllerProvider.future),
      throwsA(isA<NetworkException>()),
    );
    final state = container.read(surahListControllerProvider);
    expect(state.hasError, true);
    expect(state.error, isA<AppException>());
  });
}
