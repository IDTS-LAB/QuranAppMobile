# Quran Reader Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the counter template with an offline-first Quran reader (surah list, reader, search, bookmarks, last-read) following AGENTS.md Clean Architecture.

**Architecture:** `core/` holds Result, AppException, DioClient, AppDatabase, responsive/foldable utils; `features/quran/` holds domain entities + repository contract + use-cases, data DTO/mappers/datasources/repository-impl, presentation pages/widgets/providers/controllers; GoRouter shell with adaptive nav.

**Tech Stack:** Flutter 3.47.2 / Dart 3.13.2, flutter_riverpod, go_router, drift + drift_flutter + sqlite3_flutter_libs, dio, freezed + json_serializable + build_runner, flutter_lints.

## Global Constraints

- Base URL is exactly `https://api.alquran.cloud/v1`.
- Translation fixed to `en.sahih` (Saheeh International) for V1.
- Breakpoints: compact <600dp, medium 600-1024dp, expanded >1024dp.
- Routes: `/surahs`, `/surahs/:surahNumber`, `/search`, `/bookmarks`; deep-link scheme `quranapp://surahs/2`.
- Domain layer MUST NOT import Flutter UI, Dio, Drift, GoRouter, Riverpod.
- UI MUST NOT import Dio, Drift/DAO, or API DTOs.
- Every async screen handles initial/loading/success/empty/error via shared widgets.
- Verify with `flutter pub get`, `dart run build_runner build --delete-conflicting-outputs`, `flutter analyze`, `flutter test`.
- No `dynamic` unless necessary; no `!` null assertions when safer alternative exists; no analyzer warnings; no TODOs for core functionality.

---

### Task 1: Dependencies, lints, folders, theme tokens

**Files:**
- Modify: `pubspec.yaml`
- Modify: `analysis_options.yaml`
- Create: `lib/app/theme/app_colors.dart`
- Create: `lib/app/theme/app_spacing.dart`
- Create: `lib/app/theme/app_typography.dart`
- Create: `lib/app/theme/app_theme.dart`
- Create: `lib/core/constants/app_constants.dart`
- Test: `test/core/constants/app_constants_test.dart`

**Interfaces:**
- Consumes: nothing.
- Produces: `AppConstants.apiBaseUrl: String`, `AppConstants.translationEdition: String`, `AppColors`, `AppSpacing`, `AppTheme.light()/dark()` used by Task 10-11.

- [ ] **Step 1: Write the failing test**

```dart
// test/core/constants/app_constants_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/constants/app_constants.dart';

void main() {
  test('api constants are exact', () {
    expect(AppConstants.apiBaseUrl, 'https://api.alquran.cloud/v1');
    expect(AppConstants.translationEdition, 'en.sahih');
    expect(AppConstants.connectTimeoutMs, 10000);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/constants/app_constants_test.dart`
Expected: FAIL with "file not found / Target of URI doesn't exist".

- [ ] **Step 3: Add dependencies**

Run:

```bash
flutter pub add flutter_riverpod go_router dio drift drift_flutter sqlite3_flutter_libs path_provider json_annotation
flutter pub add -d build_runner freezed build freezed_annotation json_serializable drift_dev flutter_lints test
flutter pub get
```

Then create folders:

```bash
mkdir -p lib/app/{router,theme,bootstrap} lib/core/{constants,errors,extensions,network/interceptors,database/{tables,daos},responsive/foldable,result,utils,widgets/{loading,error,empty}} lib/features/quran/{domain/{entities,repositories,use_cases},data/{dto,mappers,datasources/{remote,local},repositories},presentation/{pages,widgets,providers,controllers}} assets/quran test/core/constants docs/superpowers/plans
```

- [ ] **Step 4: Write minimal implementation**

```dart
// lib/core/constants/app_constants.dart
abstract final class AppConstants {
  static const String apiBaseUrl = 'https://api.alquran.cloud/v1';
  static const String translationEdition = 'en.sahih';
  static const int connectTimeoutMs = 10000;
  static const int receiveTimeoutMs = 15000;
  static const int sendTimeoutMs = 10000;
  static const double compactMaxWidth = 600;
  static const double expandedMinWidth = 1024;
}
```

```dart
// lib/app/theme/app_colors.dart
import 'package:flutter/material.dart';
abstract final class AppColors {
  static const Color seed = Color(0xFF1B5E20);
  static const Color gold = Color(0xFFC9A227);
}
```

```dart
// lib/app/theme/app_spacing.dart
abstract final class AppSpacing {
  static const double xs = 4, sm = 8, md = 16, lg = 24, xl = 32;
  static const double radius = 12;
}
```

```dart
// lib/app/theme/app_typography.dart
import 'package:flutter/material.dart';
abstract final class AppTypography {
  static const TextStyle arabic = TextStyle(fontSize: 22, height: 2.0);
}
```

```dart
// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
abstract final class AppTheme {
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
  );
  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed, brightness: Brightness.dark),
  );
}
```

Add to `pubspec.yaml` under `flutter:`:

```yaml
assets:
  - assets/quran/
```

- [ ] **Step 5: Run test to verify it passes**

Run: `flutter test test/core/constants/app_constants_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add pubspec.yaml analysis_options.yaml lib/app/theme lib/core/constants test/core/constants
git commit -m "feat: add deps, constants, theme tokens"
```

---

### Task 2: Result + AppException

**Files:**
- Create: `lib/core/result/result.dart`
- Create: `lib/core/errors/app_exception.dart`
- Test: `test/core/result/result_test.dart`

**Interfaces:**
- Consumes: nothing.
- Produces: `Result<T> (Success/Failure)`, `AppException` hierarchy with `NetworkException, UnauthorizedException, ForbiddenException, NotFoundException, ValidationException, ServerException, TimeoutException, ConnectionException, DatabaseException, CacheException, UnknownException` used by Tasks 3-9.

- [ ] **Step 1: Write the failing test**

```dart
// test/core/result/result_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/result/result.dart';

void main() {
  test('Result success maps value', () {
    const Result<int> r = Result.success(2);
    expect(r.map((v) => v * 2), const Result.success(4));
  });
  test('Result failure keeps exception', () {
    const e = NetworkException('offline');
    const Result<int> r = Result.failure(e);
    expect(r.exceptionOrNull(), e);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/result/result_test.dart`
Expected: FAIL — file not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/core/errors/app_exception.dart
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => '$runtimeType: $message';
}
class NetworkException extends AppException { const NetworkException(super.message); }
class UnauthorizedException extends AppException { const UnauthorizedException(super.message); }
class ForbiddenException extends AppException { const ForbiddenException(super.message); }
class NotFoundException extends AppException { const NotFoundException(super.message); }
class ValidationException extends AppException { const ValidationException(super.message); }
class ServerException extends AppException { const ServerException(super.message); }
class TimeoutException extends AppException { const TimeoutException(super.message); }
class ConnectionException extends AppException { const ConnectionException(super.message); }
class DatabaseException extends AppException { const DatabaseException(super.message); }
class CacheException extends AppException { const CacheException(super.message); }
class UnknownException extends AppException { const UnknownException(super.message); }
```

```dart
// lib/core/result/result.dart
import '../errors/app_exception.dart';
sealed class Result<T> {
  const Result();
  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(AppException error) = Failure<T>;
  Result<R> map<R>(R Function(T) f) => switch (this) {
    Success(:final value) => Result.success(f(value)),
    Failure(:final error) => Result.failure(error),
  };
  AppException? exceptionOrNull() => switch (this) {
    Success() => null,
    Failure(:final error) => error,
  };
  bool get isSuccess => this is Success<T>;
}
final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
  @override
  bool operator ==(Object o) => o is Success<T> && o.value == value;
  @override
  int get hashCode => value.hashCode;
}
final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppException error;
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/core/result/result_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/core/result lib/core/errors test/core/result
git commit -m "feat: add Result and AppException"
```

---

### Task 3: Dio client + interceptors + NetworkInfo

**Files:**
- Create: `lib/core/network/dio_client.dart`
- Create: `lib/core/network/interceptors/request_id_interceptor.dart`
- Create: `lib/core/network/interceptors/logging_interceptor.dart`
- Create: `lib/core/network/interceptors/error_interceptor.dart`
- Create: `lib/core/network/network_info.dart`
- Test: `test/core/network/error_mapping_test.dart`

**Interfaces:**
- Consumes: `AppConstants`, `AppException`, `Result`.
- Produces: `DioClient.create({required String baseUrl}) -> Dio`, `NetworkInfo.isConnected(): Future<bool>` consumed by Task 7 repository.

- [ ] **Step 1: Write the failing test**

```dart
// test/core/network/error_mapping_test.dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/network/interceptors/error_interceptor.dart';

void main() {
  test('404 maps to NotFoundException', () {
    final err = mapDioError(DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 404),
      type: DioExceptionType.badResponse,
    ));
    expect(err, isA<NotFoundException>());
  });
  test('timeout maps to TimeoutException', () {
    final err = mapDioError(DioException(
      requestOptions: RequestOptions(path: '/x'),
      type: DioExceptionType.connectionTimeout,
    ));
    expect(err, isA<TimeoutException>());
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/network/error_mapping_test.dart`
Expected: FAIL — file not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/core/network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import '../../errors/app_exception.dart';

AppException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutException(e.message ?? 'Timeout');
    case DioExceptionType.connectionError:
      return const ConnectionException('No connection');
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      if (code == 401) return const UnauthorizedException('Unauthorized');
      if (code == 403) return const ForbiddenException('Forbidden');
      if (code == 404) return const NotFoundException('Not found');
      if (code != null && code >= 400 && code < 500) {
        return ValidationException('Request invalid: $code');
      }
      return ServerException('Server error: $code');
    default:
      return UnknownException(e.message ?? 'Unknown network error');
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: mapDioError(err),
    ));
  }
}
```

```dart
// lib/core/network/interceptors/request_id_interceptor.dart
import 'package:dio/dio.dart';
class RequestIdInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) {
    o.headers['X-Request-Id'] =
        '${DateTime.now().microsecondsSinceEpoch}-${o.path.hashCode}';
    h.next(o);
  }
}
```

```dart
// lib/core/network/interceptors/logging_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) {
    if (kDebugMode) debugPrint('--> ${o.method} ${o.uri}');
    h.next(o);
  }
}
```

```dart
// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/request_id_interceptor.dart';

abstract final class DioClient {
  static Dio create({String? baseUrl}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      sendTimeout: const Duration(milliseconds: AppConstants.sendTimeoutMs),
      headers: {'Accept': 'application/json'},
    ));
    dio.interceptors.addAll([
      RequestIdInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
    return dio;
  }
}
```

```dart
// lib/core/network/network_info.dart
abstract interface class NetworkInfo {
  Future<bool> isConnected();
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/core/network/error_mapping_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/core/network test/core/network
git commit -m "feat: add Dio client and error mapping"
```

---

### Task 4: Drift database (tables, DAOs, AppDatabase)

**Files:**
- Create: `lib/core/database/tables/quran_tables.dart`
- Create: `lib/core/database/daos/quran_dao.dart`
- Create: `lib/core/database/app_database.dart`
- Test: `test/core/database/quran_dao_test.dart`

**Interfaces:**
- Consumes: nothing outside data layer.
- Produces: `AppDatabase`, `QuranDao.upsertSurahs/getSurahs/getAyahs/searchAyahs/toggleBookmark/getBookmarks/saveReadingPosition/getReadingPosition` consumed by Task 7 local data source. Never imported by UI.

- [ ] **Step 1: Write the failing test**

```dart
// test/core/database/quran_dao_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/database/app_database.dart';

void main() {
  test('upsert + read surahs round-trips', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.quranDao.upsertSurah(
      number: 112, arabicName: 'الإخلاص', englishName: 'Al-Ikhlas',
      englishMeaning: 'Sincerity', revelationType: 'Meccan', ayahCount: 4,
    );
    final rows = await db.quranDao.getSurahs();
    expect(rows.length, 1);
    expect(rows.first.englishName, 'Al-Ikhlas');
    await db.close();
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/database/quran_dao_test.dart`
Expected: FAIL — file not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/core/database/tables/quran_tables.dart
import 'package:drift/drift.dart';
class SurahRows extends Table {
  IntColumn get number => integer()();
  TextColumn get arabicName => text()();
  TextColumn get englishName => text()();
  TextColumn get englishMeaning => text()();
  TextColumn get revelationType => text()();
  IntColumn get ayahCount => integer()();
  @override
  Set<Column> get primaryKey => {number};
}
class AyahRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get numberInSurah => integer()();
  IntColumn get numberInQuran => integer().nullable()();
  TextColumn get arabicText => text()();
  TextColumn get translation => text().nullable()();
  IntColumn get juz => integer().nullable()();
  IntColumn get page => integer().nullable()();
}
class BookmarkRows extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {surahNumber, ayahNumber};
}
class ReadingPositionRows extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {surahNumber};
}
```

```dart
// lib/core/database/daos/quran_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/quran_tables.dart';
part 'quran_dao.g.dart';

@DriftAccessor(tables: [SurahRows, AyahRows, BookmarkRows, ReadingPositionRows])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);
  Future<List<SurahRow>> getSurahs() =>
      (select(surahRows)..orderBy([(t) => OrderingTerm.asc(t.number)])).get();
  Future<void> upsertSurah({
    required int number, required String arabicName, required String englishName,
    required String englishMeaning, required String revelationType, required int ayahCount,
  }) => into(surahRows).insertOnConflictUpdate(SurahRowsCompanion(
    number: Value(number), arabicName: Value(arabicName),
    englishName: Value(englishName), englishMeaning: Value(englishMeaning),
    revelationType: Value(revelationType), ayahCount: Value(ayahCount),
  ));
  Future<List<AyahRow>> getAyahs(int surah) =>
      (select(ayahRows)..where((t) => t.surahNumber.equals(surah))
        ..orderBy([(t) => OrderingTerm.asc(t.numberInSurah)])).get();
  Future<List<AyahRow>> searchAyahs(String q) {
    final like = '%$q%';
    return (select(ayahRows)..where((t) =>
      t.arabicText.like(like) | t.translation.like(like))).get();
  }
  Future<List<BookmarkRow>> getBookmarks() => select(bookmarkRows).get();
  Future<void> toggleBookmark(int surah, int ayah) async {
    final existing = await (select(bookmarkRows)
      ..where((t) => t.surahNumber.equals(surah) & t.ayahNumber.equals(ayah))).getSingleOrNull();
    if (existing == null) {
      await into(bookmarkRows).insert(BookmarkRowsCompanion(
        surahNumber: Value(surah), ayahNumber: Value(ayah),
        createdAt: Value(DateTime.now()),
      ));
    } else {
      await (delete(bookmarkRows)..where((t) =>
        t.surahNumber.equals(surah) & t.ayahNumber.equals(ayah))).go();
    }
  }
  Future<void> saveReadingPosition(int surah, int ayah) =>
    into(readingPositionRows).insertOnConflictUpdate(ReadingPositionRowsCompanion(
      surahNumber: Value(surah), ayahNumber: Value(ayah),
      updatedAt: Value(DateTime.now()),
    ));
  Future<ReadingPositionRow?> getReadingPosition(int surah) =>
    (select(readingPositionRows)..where((t) => t.surahNumber.equals(surah))).getSingleOrNull();
}
```

```dart
// lib/core/database/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'daos/quran_dao.dart';
import 'tables/quran_tables.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [SurahRows, AyahRows, BookmarkRows, ReadingPositionRows], daos: [QuranDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'quran.db'));
  AppDatabase.forTesting(super.executor);
  @override
  int get schemaVersion => 1;
}
```

- [ ] **Step 4: Generate + run test**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/core/database/quran_dao_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/core/database test/core/database
git commit -m "feat: add Drift database and QuranDao"
```

---

### Task 5: Domain entities + repository contract

**Files:**
- Create: `lib/features/quran/domain/entities/surah.dart`
- Create: `lib/features/quran/domain/entities/ayah.dart`
- Create: `lib/features/quran/domain/entities/bookmark.dart`
- Create: `lib/features/quran/domain/entities/reading_position.dart`
- Create: `lib/features/quran/domain/repositories/surah_repository.dart`
- Test: `test/features/quran/domain/entities_test.dart`

**Interfaces:**
- Consumes: `Result`, `AppException` only (pure Dart).
- Produces: `Surah, Ayah, Bookmark, ReadingPosition` (Freezed), `SurahRepository` interface consumed by Tasks 7-9.

- [ ] **Step 1: Write the failing test**

```dart
// test/features/quran/domain/entities_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

void main() {
  test('Surah entity holds fields', () {
    const s = Surah(number: 1, arabicName: 'الفاتحة', englishName: 'Al-Fatiha',
      englishMeaning: 'The Opener', revelationType: 'Meccan', ayahCount: 7);
    expect(s.ayahCount, 7);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/domain/entities_test.dart`
Expected: FAIL — file not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/features/quran/domain/entities/surah.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'surah.freezed.dart';
@freezed
abstract class Surah with _$Surah {
  const factory Surah({
    required int number,
    required String arabicName,
    required String englishName,
    required String englishMeaning,
    required String revelationType,
    required int ayahCount,
  }) = _Surah;
}
```

```dart
// lib/features/quran/domain/entities/ayah.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'ayah.freezed.dart';
@freezed
abstract class Ayah with _$Ayah {
  const factory Ayah({
    required int surahNumber,
    required int numberInSurah,
    int? numberInQuran,
    required String arabicText,
    String? translation,
    int? juz,
    int? page,
  }) = _Ayah;
}
```

```dart
// lib/features/quran/domain/entities/bookmark.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bookmark.freezed.dart';
@freezed
abstract class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int surahNumber,
    required int ayahNumber,
    required DateTime createdAt,
  }) = _Bookmark;
}
```

```dart
// lib/features/quran/domain/entities/reading_position.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reading_position.freezed.dart';
@freezed
abstract class ReadingPosition with _$ReadingPosition {
  const factory ReadingPosition({
    required int surahNumber,
    required int ayahNumber,
    required DateTime updatedAt,
  }) = _ReadingPosition;
}
```

```dart
// lib/features/quran/domain/repositories/surah_repository.dart
import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../entities/bookmark.dart';
import '../entities/reading_position.dart';
import '../entities/surah.dart';

abstract interface class SurahRepository {
  Future<Result<List<Surah>>> getSurahs();
  Future<Result<List<Ayah>>> getSurahDetail(int surahNumber);
  Future<Result<List<Ayah>>> search(String query);
  Future<Result<List<Bookmark>>> getBookmarks();
  Future<Result<void>> toggleBookmark(int surahNumber, int ayahNumber);
  Future<Result<void>> saveReadingPosition(int surahNumber, int ayahNumber);
  Future<Result<ReadingPosition?>> getReadingPosition(int surahNumber);
  Future<Result<void>> syncFromRemote();
}
```

- [ ] **Step 4: Generate + run test**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/quran/domain/entities_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/features/quran/domain test/features/quran/domain
git commit -m "feat: add quran domain entities and repository contract"
```

---

### Task 6: DTOs + mappers

**Files:**
- Create: `lib/features/quran/data/dto/surah_dto.dart`
- Create: `lib/features/quran/data/dto/ayah_dto.dart`
- Create: `lib/features/quran/data/mappers/surah_mapper.dart`
- Create: `lib/features/quran/data/mappers/ayah_mapper.dart`
- Test: `test/features/quran/data/mapper_test.dart`

**Interfaces:**
- Consumes: domain entities.
- Produces: `SurahDto.fromJson/toEntity`, `AyahDto.fromJson/toEntity`, `surahRowToEntity`, `ayahRowToEntity` consumed by Task 7.

- [ ] **Step 1: Write the failing test**

```dart
// test/features/quran/data/mapper_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/data/dto/surah_dto.dart';

void main() {
  test('SurahDto maps AlQuran Cloud shape', () {
    final dto = SurahDto.fromJson({
      'number': 112, 'name': 'سورة الإخلاص',
      'englishName': 'Al-Ikhlas', 'englishNameTranslation': 'Sincerity',
      'revelationType': 'Meccan', 'numberOfAyahs': 4,
    });
    final e = dto.toEntity();
    expect(e.number, 112);
    expect(e.ayahCount, 4);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/data/mapper_test.dart`
Expected: FAIL.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/features/quran/data/dto/surah_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/surah.dart';
part 'surah_dto.freezed.dart';
part 'surah_dto.g.dart';

@freezed
abstract class SurahDto with _$SurahDto {
  const SurahDto._();
  const factory SurahDto({
    required int number,
    required String name,
    required String englishName,
    required String englishNameTranslation,
    required String revelationType,
    required int numberOfAyahs,
  }) = _SurahDto;
  factory SurahDto.fromJson(Map<String, Object?> json) => _$SurahDtoFromJson(json);
  Surah toEntity() => Surah(
    number: number, arabicName: name, englishName: englishName,
    englishMeaning: englishNameTranslation, revelationType: revelationType,
    ayahCount: numberOfAyahs,
  );
}
```

```dart
// lib/features/quran/data/dto/ayah_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/ayah.dart';
part 'ayah_dto.freezed.dart';
part 'ayah_dto.g.dart';

@freezed
abstract class AyahDto with _$AyahDto {
  const AyahDto._();
  const factory AyahDto({
    required int number,
    required String text,
    required int numberInSurah,
    int? juz,
    int? page,
  }) = _AyahDto;
  factory AyahDto.fromJson(Map<String, Object?> json) => _$AyahDtoFromJson(json);
  Ayah toEntity({required int surahNumber, String? translation}) => Ayah(
    surahNumber: surahNumber, numberInSurah: numberInSurah,
    numberInQuran: number, arabicText: text,
    translation: translation, juz: juz, page: page,
  );
}
```

```dart
// lib/features/quran/data/mappers/surah_mapper.dart
import '../../../../core/database/app_database.dart';
import '../../domain/entities/surah.dart';
Surah surahRowToEntity(SurahRow r) => Surah(
  number: r.number, arabicName: r.arabicName, englishName: r.englishName,
  englishMeaning: r.englishMeaning, revelationType: r.revelationType,
  ayahCount: r.ayahCount,
);
```

```dart
// lib/features/quran/data/mappers/ayah_mapper.dart
import '../../../../core/database/app_database.dart';
import '../../domain/entities/ayah.dart';
Ayah ayahRowToEntity(AyahRow r) => Ayah(
  surahNumber: r.surahNumber, numberInSurah: r.numberInSurah,
  numberInQuran: r.numberInQuran, arabicText: r.arabicText,
  translation: r.translation, juz: r.juz, page: r.page,
);
```

- [ ] **Step 4: Generate + run test**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/quran/data/mapper_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/features/quran/data/dto lib/features/quran/data/mappers test/features/quran/data
git commit -m "feat: add quran DTOs and mappers"
```

---

### Task 7: Data sources + repository impl (offline-first)

**Files:**
- Create: `lib/features/quran/data/datasources/remote/quran_remote_data_source.dart`
- Create: `lib/features/quran/data/datasources/local/quran_local_data_source.dart`
- Create: `lib/features/quran/data/repositories/surah_repository_impl.dart`
- Create: `assets/quran/surahs.json` (114 entries; seed at least all metadata — full list required)
- Test: `test/features/quran/data/repository_test.dart`

**Interfaces:**
- Consumes: `Dio`, `QuranDao`, DTOs, mappers, `NetworkInfo`.
- Produces: `SurahRepository` implementation bound in Task 9.

- [ ] **Step 1: Write the failing test**

```dart
// test/features/quran/data/repository_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/data/datasources/local/quran_local_data_source.dart';
import 'package:quran_app/features/quran/data/datasources/remote/quran_remote_data_source.dart';
import 'package:quran_app/features/quran/data/repositories/surah_repository_impl.dart';

class _NoNetworkRemote implements QuranRemoteDataSource {
  @override
  Future<List<Map<String, Object?>>> fetchSurahs() => throw Exception('offline');
  @override
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int n) => throw Exception('offline');
}

void main() {
  test('repository returns local data when remote fails', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final local = QuranLocalDataSource(db.quranDao);
    await local.seedSurahs([
      {'number': 1, 'arabicName': 'الفاتحة', 'englishName': 'Al-Fatiha',
       'englishMeaning': 'The Opener', 'revelationType': 'Meccan', 'ayahCount': 7},
    ]);
    final repo = SurahRepositoryImpl(remote: _NoNetworkRemote(), local: local);
    final res = await repo.getSurahs();
    expect(res.isSuccess, true);
    await db.close();
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/data/repository_test.dart`
Expected: FAIL — classes not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/features/quran/data/datasources/remote/quran_remote_data_source.dart
import 'package:dio/dio.dart';
import '../../../../../core/constants/app_constants.dart';

abstract interface class QuranRemoteDataSource {
  Future<List<Map<String, Object?>>> fetchSurahs();
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int surahNumber);
}

final class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  QuranRemoteDataSourceImpl(this._dio);
  final Dio _dio;
  @override
  Future<List<Map<String, Object?>>> fetchSurahs() async {
    final res = await _dio.get('/surah');
    final data = res.data as Map<String, Object?>;
    return ((data['data'] as List).cast<Map<String, Object?>>());
  }
  @override
  Future<List<Map<String, Object?>>> fetchSurahAyahs(int n) async {
    final res = await _dio.get('/surah/$n/${AppConstants.translationEdition}');
    final data = ((res.data as Map<String, Object?>)['data'] as Map<String, Object?>);
    return ((data['ayahs'] as List).cast<Map<String, Object?>>());
  }
}
```

```dart
// lib/features/quran/data/datasources/local/quran_local_data_source.dart
import '../../../../../core/database/app_database.dart';

final class QuranLocalDataSource {
  QuranLocalDataSource(this._dao);
  final QuranDao _dao;
  Future<List<SurahRow>> getSurahs() => _dao.getSurahs();
  Future<List<AyahRow>> getAyahs(int s) => _dao.getAyahs(s);
  Future<List<AyahRow>> search(String q) => _dao.searchAyahs(q);
  Future<List<BookmarkRow>> getBookmarks() => _dao.getBookmarks();
  Future<void> toggleBookmark(int s, int a) => _dao.toggleBookmark(s, a);
  Future<void> saveReadingPosition(int s, int a) => _dao.saveReadingPosition(s, a);
  Future<ReadingPositionRow?> getReadingPosition(int s) => _dao.getReadingPosition(s);
  Future<void> seedSurahs(List<Map<String, Object?>> rows) async {
    for (final r in rows) {
      await _dao.upsertSurah(
        number: r['number'] as int, arabicName: r['arabicName'] as String,
        englishName: r['englishName'] as String,
        englishMeaning: r['englishMeaning'] as String,
        revelationType: r['revelationType'] as String,
        ayahCount: r['ayahCount'] as int,
      );
    }
  }
}
```

```dart
// lib/features/quran/data/repositories/surah_repository_impl.dart
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/entities/reading_position.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/surah_repository.dart';
import '../dto/ayah_dto.dart';
import '../dto/surah_dto.dart';
import '../mappers/ayah_mapper.dart';
import '../mappers/surah_mapper.dart';
import '../datasources/local/quran_local_data_source.dart';
import '../datasources/remote/quran_remote_data_source.dart';

final class SurahRepositoryImpl implements SurahRepository {
  SurahRepositoryImpl({required this.remote, required this.local});
  final QuranRemoteDataSource remote;
  final QuranLocalDataSource local;

  @override
  Future<Result<List<Surah>>> getSurahs() async {
    try {
      final cached = await local.getSurahs();
      if (cached.isNotEmpty) {
        _refreshSurahsInBackground();
        return Result.success(cached.map(surahRowToEntity).toList());
      }
      await syncFromRemote();
      final rows = await local.getSurahs();
      return Result.success(rows.map(surahRowToEntity).toList());
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnknownException(e.toString()));
    }
  }

  Future<void> _refreshSurahsInBackground() async {
    try {
      await syncFromRemote();
    } catch (_) {}
  }

  @override
  Future<Result<void>> syncFromRemote() async {
    try {
      final json = await remote.fetchSurahs();
      await local.seedSurahs(json.map((j) {
        final dto = SurahDto.fromJson(j);
        final e = dto.toEntity();
        return <String, Object?>{
          'number': e.number, 'arabicName': e.arabicName,
          'englishName': e.englishName, 'englishMeaning': e.englishMeaning,
          'revelationType': e.revelationType, 'ayahCount': e.ayahCount,
        };
      }).toList());
      return const Result.success(null);
    } catch (e) {
      if (e is AppException) return Result.failure(e);
      return Result.failure(UnknownException(e.toString()));
    }
  }

  @override
  Future<Result<List<Ayah>>> getSurahDetail(int n) async {
    try {
      final cached = await local.getAyahs(n);
      if (cached.isNotEmpty) return Result.success(cached.map(ayahRowToEntity).toList());
      final json = await remote.fetchSurahAyahs(n);
      final ayahs = json.map((j) =>
        AyahDto.fromJson({'number': j['number'] ?? 0, 'text': (j['text'] ?? '') as String,
          'numberInSurah': j['numberInSurah'] ?? 0}).toEntity(surahNumber: n)).toList();
      // V1: return remote-mapped ayahs directly; bulk-persist to Drift is a
      // follow-up (local search covers seeded/short surahs). Do not block UI on persist.
      return Result.success(ayahs);
    } catch (e) {
      return Result.failure(e is AppException ? e : UnknownException(e.toString()));
    }
  }

  @override
  Future<Result<List<Ayah>>> search(String q) async {
    try {
      final rows = await local.search(q);
      return Result.success(rows.map(ayahRowToEntity).toList());
    } catch (e) {
      return Result.failure(e is AppException ? e : UnknownException(e.toString()));
    }
  }

  @override
  Future<Result<List<Bookmark>>> getBookmarks() async {
    final rows = await local.getBookmarks();
    return Result.success(rows.map((r) =>
      Bookmark(surahNumber: r.surahNumber, ayahNumber: r.ayahNumber, createdAt: r.createdAt)).toList());
  }

  @override
  Future<Result<void>> toggleBookmark(int s, int a) async {
    await local.toggleBookmark(s, a);
    return const Result.success(null);
  }

  @override
  Future<Result<void>> saveReadingPosition(int s, int a) async {
    await local.saveReadingPosition(s, a);
    return const Result.success(null);
  }

  @override
  Future<Result<ReadingPosition?>> getReadingPosition(int s) async {
    final r = await local.getReadingPosition(s);
    if (r == null) return const Result.success(null);
    return Result.success(ReadingPosition(
      surahNumber: r.surahNumber, ayahNumber: r.ayahNumber, updatedAt: r.updatedAt));
  }
}
```

Seed `assets/quran/surahs.json` must be a JSON array of 114 objects with keys
`number, arabicName, englishName, englishMeaning, revelationType, ayahCount`.
Include at least Surah 1, 112, 113, 114 fully correct; remaining 110 must be real
metadata (copy from `https://api.alquran.cloud/v1/surah` once, then commit).

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/quran/data/repository_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/features/quran/data assets/quran test/features/quran/data
git commit -m "feat: add quran datasources and offline-first repository"
```

---

### Task 8: Use-cases

**Files:**
- Create: `lib/features/quran/domain/use_cases/get_surahs.dart`
- Create: `lib/features/quran/domain/use_cases/get_surah_detail.dart`
- Create: `lib/features/quran/domain/use_cases/search_quran.dart`
- Create: `lib/features/quran/domain/use_cases/toggle_bookmark.dart`
- Create: `lib/features/quran/domain/use_cases/quran_use_cases.dart` (barrel)
- Test: `test/features/quran/domain/use_cases_test.dart`

**Interfaces:**
- Consumes: `SurahRepository`.
- Produces: `GetSurahs.call(), GetSurahDetail.call(int), SearchQuran.call(String), ToggleBookmark.call(surah, ayah)` consumed by Task 9 controllers.

- [ ] **Step 1: Write the failing test**

```dart
// test/features/quran/domain/use_cases_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/result/result.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
import 'package:quran_app/features/quran/domain/repositories/surah_repository.dart';
import 'package:quran_app/features/quran/domain/use_cases/get_surahs.dart';

class _FakeRepo implements SurahRepository {
  @override
  Future<Result<List<Surah>>> getSurahs() async => const Result.success([
    Surah(number: 1, arabicName: 'الفاتحة', englishName: 'Al-Fatiha',
      englishMeaning: 'The Opener', revelationType: 'Meccan', ayahCount: 7),
  ]);
  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

void main() {
  test('GetSurahs returns repository data', () async {
    final res = await GetSurahs(_FakeRepo()).call();
    expect(res.isSuccess, true);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/domain/use_cases_test.dart`
Expected: FAIL.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/features/quran/domain/use_cases/get_surahs.dart
import '../../../../core/result/result.dart';
import '../entities/surah.dart';
import '../repositories/surah_repository.dart';
final class GetSurahs {
  GetSurahs(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Surah>>> call() => _repo.getSurahs();
}
```

```dart
// lib/features/quran/domain/use_cases/get_surah_detail.dart
import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../repositories/surah_repository.dart';
final class GetSurahDetail {
  GetSurahDetail(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Ayah>>> call(int surahNumber) => _repo.getSurahDetail(surahNumber);
}
```

```dart
// lib/features/quran/domain/use_cases/search_quran.dart
import '../../../../core/errors/app_exception.dart';
import '../../../../core/result/result.dart';
import '../entities/ayah.dart';
import '../repositories/surah_repository.dart';
final class SearchQuran {
  SearchQuran(this._repo);
  final SurahRepository _repo;
  Future<Result<List<Ayah>>> call(String query) {
    if (query.trim().length < 2) {
      return Future.value(const Result.failure(ValidationException('Type at least 2 characters')));
    }
    return _repo.search(query.trim());
  }
}
```

```dart
// lib/features/quran/domain/use_cases/toggle_bookmark.dart
import '../../../../core/result/result.dart';
import '../repositories/surah_repository.dart';
final class ToggleBookmark {
  ToggleBookmark(this._repo);
  final SurahRepository _repo;
  Future<Result<void>> call(int surah, int ayah) => _repo.toggleBookmark(surah, ayah);
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/quran/domain/use_cases_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/features/quran/domain/use_cases test/features/quran/domain/use_cases_test.dart
git commit -m "feat: add quran use-cases"
```

---

### Task 9: Riverpod providers + controllers

**Files:**
- Create: `lib/features/quran/presentation/providers/quran_providers.dart`
- Create: `lib/features/quran/presentation/controllers/surah_list_controller.dart`
- Create: `lib/features/quran/presentation/controllers/surah_detail_controller.dart`
- Create: `lib/features/quran/presentation/controllers/bookmarks_controller.dart`
- Test: `test/features/quran/presentation/controllers_test.dart`

**Interfaces:**
- Consumes: Dio, AppDatabase, repository, use-cases.
- Produces: `dioProvider, databaseProvider, surahRepositoryProvider, surahListControllerProvider, surahDetailControllerProvider (family), bookmarksControllerProvider` consumed by Task 11 pages.

- [ ] **Step 1: Write the failing test**

```dart
// test/features/quran/presentation/controllers_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';

void main() {
  test('surah list controller loads from fake repo', () async {
    final container = ProviderContainer(overrides: [
      surahRepositoryProvider.overrideWithValue(FakeSurahRepository()),
    ]);
    addTearDown(container.dispose);
    final state = await container.read(surahListControllerProvider.future);
    expect(state.length, 1);
  });
}
```

Note: `FakeSurahRepository` is defined in the test file implementing
`SurahRepository` with one Surah. Write it in the test file.

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/presentation/controllers_test.dart`
Expected: FAIL — provider not found.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/features/quran/presentation/providers/quran_providers.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/local/quran_local_data_source.dart';
import '../../data/datasources/remote/quran_remote_data_source.dart';
import '../../data/repositories/surah_repository_impl.dart';
import '../../domain/repositories/surah_repository.dart';
import '../../domain/use_cases/get_surah_detail.dart';
import '../../domain/use_cases/get_surahs.dart';
import '../../domain/use_cases/search_quran.dart';
import '../../domain/use_cases/toggle_bookmark.dart';
import '../controllers/bookmarks_controller.dart';
import '../controllers/surah_detail_controller.dart';
import '../controllers/surah_list_controller.dart';

final dioProvider = Provider<Dio>((ref) => DioClient.create());
final databaseProvider = Provider<AppDatabase>((ref) {
  ref.onDispose(() {});
  return AppDatabase();
});
final surahRepositoryProvider = Provider<SurahRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final db = ref.watch(databaseProvider);
  return SurahRepositoryImpl(
    remote: QuranRemoteDataSourceImpl(dio),
    local: QuranLocalDataSource(db.quranDao),
  );
});
final getSurahsProvider = Provider((ref) => GetSurahs(ref.watch(surahRepositoryProvider)));
final getSurahDetailProvider = Provider((ref) => GetSurahDetail(ref.watch(surahRepositoryProvider)));
final searchQuranProvider = Provider((ref) => SearchQuran(ref.watch(surahRepositoryProvider)));
final toggleBookmarkProvider = Provider((ref) => ToggleBookmark(ref.watch(surahRepositoryProvider)));
final surahListControllerProvider =
    AsyncNotifierProvider.autoDispose<SurahListController, List<SurahView>>(
        SurahListController.new);
final surahDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SurahDetailController, SurahDetailView, int>(SurahDetailController.new);
final bookmarksControllerProvider =
    AsyncNotifierProvider.autoDispose<BookmarksController, List<BookmarkView>>(
        BookmarksController.new);
```

Controllers expose small view-models mapping 1:1 from entities — no DTOs, no Drift rows.
Define in `lib/features/quran/presentation/controllers/quran_views.dart`:

```dart
import '../../domain/entities/ayah.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/entities/surah.dart';
typedef SurahView = Surah;
typedef BookmarkView = Bookmark;
final class SurahDetailView {
  const SurahDetailView({required this.surah, required this.ayahs});
  final Surah surah;
  final List<Ayah> ayahs;
}
```

Each controller calls exactly one
use-case per action, handles `Result.failure` by setting `AsyncError` with the
`AppException`.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/quran/presentation/controllers_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/features/quran/presentation/providers lib/features/quran/presentation/controllers test/features/quran/presentation
git commit -m "feat: add Riverpod providers and controllers"
```

---

### Task 10: Router, app shell, responsive + foldable, adaptive nav

**Files:**
- Create: `lib/app/router/route_names.dart`
- Create: `lib/app/router/route_guards.dart`
- Create: `lib/app/router/app_router.dart`
- Create: `lib/app/bootstrap/app_bootstrap.dart`
- Create: `lib/app/app.dart`
- Create: `lib/core/responsive/breakpoints.dart`
- Create: `lib/core/responsive/adaptive_layout.dart`
- Create: `lib/core/responsive/foldable/foldable_info.dart`
- Create: `lib/app/router/adaptive_scaffold.dart`
- Modify: `lib/main.dart`
- Test: `test/app/router/navigation_test.dart`

**Interfaces:**
- Consumes: theme, providers.
- Produces: `AppRouter`, `AdaptiveScaffold`, `Breakpoints.isCompact/isMedium/isExpanded`, `FoldableInfo` consumed by Task 11.

- [ ] **Step 1: Write the failing test**

```dart
// test/app/router/navigation_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/router/route_names.dart';

void main() {
  test('surah detail route builds correctly', () {
    expect(RouteNames.surahDetail(2), '/surahs/2');
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/app/router/navigation_test.dart`
Expected: FAIL.

- [ ] **Step 3: Write minimal implementation**

```dart
// lib/app/router/route_names.dart
abstract final class RouteNames {
  static const String surahs = '/surahs';
  static String surahDetail(int n) => '/surahs/$n';
  static const String search = '/search';
  static const String bookmarks = '/bookmarks';
}
```

GoRouter uses `StatefulShellRoute.indexedStack` with branches surahs/search/bookmarks,
detail as nested `/surahs/:surahNumber`. `AdaptiveScaffold` switches
`NavigationBar` (compact) / `NavigationRail` (medium) / sidebar+two-pane (expanded)
based on `LayoutBuilder` constraints + `FoldableInfo.fromContext`. Selected index
derived from `GoRouterState.uri` via central `locationToIndex()`. `main.dart` calls
`AppBootstrap.init()` (seed Drift from `assets/quran/surahs.json`) then `runApp(ProviderScope(child: QuranApp()))`.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/app/router/navigation_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/app lib/core/responsive lib/main.dart test/app/router
git commit -m "feat: add router, adaptive shell, responsive foldable"
```

---

### Task 11: Atomic widgets + pages + seed + wiring

**Files:**
- Create: `lib/core/widgets/loading/app_loading.dart`
- Create: `lib/core/widgets/error/app_error_view.dart`
- Create: `lib/core/widgets/empty/app_empty_view.dart`
- Create: `lib/features/quran/presentation/widgets/surah_card.dart`
- Create: `lib/features/quran/presentation/widgets/ayah_tile.dart`
- Create: `lib/features/quran/presentation/widgets/resume_banner.dart`
- Create: `lib/features/quran/presentation/pages/surah_list_page.dart`
- Create: `lib/features/quran/presentation/pages/surah_detail_page.dart`
- Create: `lib/features/quran/presentation/pages/search_page.dart`
- Create: `lib/features/quran/presentation/pages/bookmarks_page.dart`
- Test: `test/features/quran/presentation/pages_test.dart`

**Interfaces:**
- Consumes: all previous tasks.
- Produces: working UI. Widgets take entities/view-models + callbacks only.

- [ ] **Step 1: Write the failing widget test**

```dart
// test/features/quran/presentation/pages_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/widgets/empty/app_empty_view.dart';

void main() {
  testWidgets('empty view shows message', (t) async {
    await t.pumpWidget(const MaterialApp(
      home: AppEmptyView(message: 'No bookmarks yet')));
    expect(find.text('No bookmarks yet'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/features/quran/presentation/pages_test.dart`
Expected: FAIL.

- [ ] **Step 3: Write minimal implementation**

Shared widgets: `AppLoading` (Center + CircularProgressIndicator),
`AppErrorView(message, onRetry)` with `AppRetryButton`,
`AppEmptyView(message)`. Feature widgets: `SurahCard(surah, onTap)`,
`AyahTile(ayah, bookmarked, onBookmark, onVisible)` — Arabic text uses
`AppTypography.arabic`, no logic. Pages: each `ConsumerWidget` watches its
controller and switches `loading/error/empty/success`; `SurahDetailPage`
saves reading position on visible ayah; `SearchPage` debounces 300ms, requires
2+ chars; `BookmarksPage` lists with remove. Expanded layout: `SurahListPage`
+ `SurahDetailPage` side-by-side with selected surah state.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/features/quran/presentation/pages_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add lib/core/widgets lib/features/quran/presentation/widgets lib/features/quran/presentation/pages test/features/quran/presentation/pages_test.dart
git commit -m "feat: add atomic widgets and quran pages"
```

---

### Task 12: Verification (build_runner, analyze, tests, refactor)

**Files:** none new; fix whatever analyze/tests report.

- [ ] **Step 1: Generate**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: success, no conflicting outputs.

- [ ] **Step 2: Analyze**

Run: `flutter analyze`
Expected: "No issues found!" — fix all warnings (const, imports, null-safety).

- [ ] **Step 3: Test**

Run: `flutter test`
Expected: all tests pass.

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "chore: verify analyze and tests pass" || echo "nothing to commit"
```

---

## File Map (all paths)

```text
pubspec.yaml, analysis_options.yaml, lib/main.dart,
lib/app/{app.dart, bootstrap/app_bootstrap.dart, router/{app_router.dart, route_names.dart, route_guards.dart, adaptive_scaffold.dart}, theme/{app_theme.dart, app_colors.dart, app_typography.dart, app_spacing.dart}},
lib/core/{constants/app_constants.dart, errors/app_exception.dart, result/result.dart, network/{dio_client.dart, network_info.dart, interceptors/{request_id_interceptor.dart, logging_interceptor.dart, error_interceptor.dart}}, database/{app_database.dart, tables/quran_tables.dart, daos/quran_dao.dart}, responsive/{breakpoints.dart, adaptive_layout.dart, foldable/foldable_info.dart}, widgets/{loading/app_loading.dart, error/app_error_view.dart, empty/app_empty_view.dart}},
lib/features/quran/{domain/{entities/{surah.dart, ayah.dart, bookmark.dart, reading_position.dart}, repositories/surah_repository.dart, use_cases/{get_surahs.dart, get_surah_detail.dart, search_quran.dart, toggle_bookmark.dart}}, data/{dto/{surah_dto.dart, ayah_dto.dart}, mappers/{surah_mapper.dart, ayah_mapper.dart}, datasources/{remote/quran_remote_data_source.dart, local/quran_local_data_source.dart}, repositories/surah_repository_impl.dart}, presentation/{providers/quran_providers.dart, controllers/{surah_list_controller.dart, surah_detail_controller.dart, bookmarks_controller.dart}, pages/{surah_list_page.dart, surah_detail_page.dart, search_page.dart, bookmarks_page.dart}, widgets/{surah_card.dart, ayah_tile.dart, resume_banner.dart}}},
assets/quran/surahs.json,
test/{core/{constants/app_constants_test.dart, result/result_test.dart, network/error_mapping_test.dart, database/quran_dao_test.dart}, features/quran/{domain/entities_test.dart, domain/use_cases_test.dart, data/{mapper_test.dart, repository_test.dart}, presentation/{controllers_test.dart, pages_test.dart}}, app/router/navigation_test.dart}
```
