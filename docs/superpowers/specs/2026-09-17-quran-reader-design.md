# Quran Reader — Design Spec (2026-09-17)

## 1. Goal
Replace the default Flutter counter template in `quran_app` with a production-grade
Quran reader implementing AGENTS.md (DDD + Clean Architecture + SOLID, Riverpod,
GoRouter, Drift+SQLite, Dio, Freezed, responsive + foldable, atomic widgets).

V1 scope (user-approved): full reader, text-only, hybrid data.

## 2. Features (V1)
- Surah list: 114 surahs, number, Arabic name, English name, ayah count, revelation type.
- Surah reader: Arabic text + English translation, ayah numbers, juz/page hints if available.
- Search: by surah name (EN/AR) and ayah text substring, local-first.
- Bookmarks: toggle per ayah, bookmarks list, remove.
- Last-read / reading position: save per surah, resume banner, continue where left off.
- Offline-first: bundled seed + API sync, cached in SQLite, works offline after first launch.
- Non-goals V1: audio recitation, tafsir, multiple translations, auth, deep-link auth guards.

## 3. Architecture
Feature-first Clean Architecture. Dependency direction: Presentation -> Application ->
Domain <- Data, Infrastructure.

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/{app_router.dart, route_names.dart, route_guards.dart}
│   ├── theme/{app_theme.dart, app_colors.dart, app_typography.dart, app_spacing.dart}
│   └── bootstrap/app_bootstrap.dart
├── core/
│   ├── constants/app_constants.dart
│   ├── errors/app_exception.dart
│   ├── extensions/
│   ├── network/{dio_client.dart, interceptors/{auth_interceptor.dart, logging_interceptor.dart, error_interceptor.dart}, network_info.dart}
│   ├── database/{app_database.dart, tables/{surahs.dart, ayahs.dart, bookmarks.dart, reading_positions.dart}, daos/}
│   ├── responsive/{breakpoints.dart, adaptive_layout.dart, foldable/foldable_info.dart}
│   ├── result/result.dart
│   ├── utils/
│   └── widgets/{loading/app_loading.dart, error/app_error_view.dart, empty/app_empty_view.dart}
├── features/quran/
│   ├── domain/{entities/{surah.dart, ayah.dart, bookmark.dart, reading_position.dart},
│   │          repositories/surah_repository.dart,
│   │          use_cases/{get_surahs.dart, get_surah_detail.dart, search_quran.dart, toggle_bookmark.dart, get_bookmarks.dart, save_reading_position.dart, get_reading_position.dart}}
│   ├── data/{dto/{surah_dto.dart, ayah_dto.dart}, mappers/{surah_mapper.dart, ayah_mapper.dart},
│   │        datasources/{remote/quran_remote_data_source.dart, local/quran_local_data_source.dart},
│   │        repositories/surah_repository_impl.dart}
│   └── presentation/{pages/{surah_list_page.dart, surah_detail_page.dart, search_page.dart, bookmarks_page.dart},
│                     widgets/{surah_card.dart, ayah_tile.dart, resume_banner.dart},
│                     providers/{quran_providers.dart}, controllers/{surah_list_controller.dart, surah_detail_controller.dart, search_controller.dart, bookmarks_controller.dart}}
├── l10n/ (reserved, not V1)
└── main.dart
```

Bookmarks/search/reading-position live inside `features/quran/` (not separate features)
to avoid over-splitting; each has its own use-case + controller.

## 4. Domain Layer (pure Dart, no Flutter/Dio/Drift/Riverpod)
- Entities (Freezed): Surah(id, number, arabicName, englishName, englishMeaning, revelationType, ayahCount), Ayah(surahNumber, numberInSurah, numberInQuran, arabicText, translation, juz, page), Bookmark(surahNumber, ayahNumber, createdAt), ReadingPosition(surahNumber, ayahNumber, updatedAt).
- Repository contract `SurahRepository`: getSurahs(), getSurahDetail(number), search(query), getBookmarks(), toggleBookmark(...), saveReadingPosition(...), getLastReadingPosition(), syncFromRemote().
- Use-cases (only meaningful ones): GetSurahs, GetSurahDetail, SearchQuran, ToggleBookmark, GetBookmarks, SaveReadingPosition, GetReadingPosition. No pass-through wrappers.

## 5. Data Layer
- DTOs (Freezed+json_serializable): SurahDto, AyahDto matching AlQuran Cloud `api.alquran.cloud/v1` + bundled seed shape. Mappers DTO<->Entity, Drift row<->Entity.
- RemoteDataSource (Dio): fetchSurahs(), fetchSurah(number) with translation fixed to `en.sahih` (Saheeh International) for V1, search handled locally for V1.
- LocalDataSource (Drift DAOs): upsertSurahs/Ayahs, watchSurahs, getAyahs(surah), searchAyahs(query) via LIKE on arabic/translation + surah names, bookmarks CRUD, reading position CRUD.
- RepositoryImpl: offline-first — emit local first, background remote refresh, persist, re-emit; `syncFromRemote` explicit; errors mapped to AppException.
- Assets: `assets/quran/surahs.json` (114 metadata) + `assets/quran/ayahs_sample.json` (short surahs full text for instant offline; full text synced via API). Documented as seed, not full mushaf.

## 6. Networking (Dio)
Central `DioClient`: baseUrl `https://api.alquran.cloud/v1`, connect 10s, receive 15s, send 10s, JSON headers, request-id interceptor, logging in debug only, error normalization interceptor. No business logic in interceptors. Exceptions: Network, Unauthorized, Forbidden, NotFound, Validation, Server, Timeout, Connection — all extend AppException. UI never sees DioException.

## 7. Persistence (Drift+SQLite)
Tables: Surahs(number PK, arabicName, englishName, englishMeaning, revelationType, ayahCount), Ayahs(id PK auto, surahNumber FK, numberInSurah, numberInQuran, arabicText, translation, juz, page), Bookmarks(surahNumber, ayahNumber composite PK, createdAt), ReadingPositions(id=1 singleton or per-surah, surahNumber, ayahNumber, updatedAt). Migrations v1 baseline, transaction for bulk upsert. DAOs per table. No Drift types leak past data layer.

## 8. State (Riverpod)
Providers compose deps: dioClientProvider -> remoteDataSource -> localDataSource (AppDatabase) -> repository -> use-cases -> controllers (AsyncNotifier, autoDispose, family for surahNumber/query). Controllers hold UI state only. Provider overrides for tests.

## 9. Navigation (GoRouter)
Routes: `/surahs`, `/surahs/:surahNumber`, `/search`, `/bookmarks`. Central route_names, app_router with StatefulShellRoute for bottom-nav tabs (Surahs/Search/Bookmarks), nested detail. Guard: DB-seeded check redirect to splash/loading. No hard-coded `context.go('/...')` in widgets — use route helpers. Deep links: `quranapp://surahs/2`.

## 10. Responsive + Foldable + Adaptive Nav
Breakpoints: compact <600dp, medium 600-1024dp, expanded >1024dp. Compact: NavigationBar + single column. Medium: NavigationRail + wider content. Expanded: sidebar + two-pane list/detail. Utilities: Breakpoints, AdaptiveLayout, ResponsiveBuilder using LayoutBuilder constraints. Foldable: FoldableInfo from MediaQuery.displayFeatures + window size; folded=compact single-pane, half-open=stacked content/controls, open=expanded two-pane avoiding hinge. Nav index from GoRouter location via central mapping.

## 11. UI System + Atomic Widgets
Central theme (colors, typography, spacing, radius). Shared AppLoading/AppErrorView(with retry)/AppEmptyView. Feature atoms: SurahCard, AyahTile, ResumeBanner, SearchField, BookmarkButton. Pages compose sections/widgets, build() stays small, const where possible, no business logic/Dio/Drift/DTOs in widgets.

## 12. Errors/Offline/Performance
Result<T> + AppException to UI. Every async screen handles initial/loading/success/empty/error. Offline banner when NetworkInfo offline, cached data preferred. Perf: const, select/family/autoDispose, ListView lazy, pagination for ayahs (or slivers), no N+1 queries.

## 13. Testing
Domain: entities, use-cases. Data: mappers, repository offline-first with fake sources, DAO tests (drift test). Presentation: controllers with provider overrides. Widget: loading/error/empty, compact/medium/expanded + folded/half-open/open variants. Commands: flutter pub get, build_runner, analyze, test.

## 14. Implementation Order (per AGENTS.md)
Core result/errors -> Dio -> Drift -> entities/contracts -> DTO/mappers/sources/repo -> use-cases -> providers/controllers -> router -> responsive/foldable -> atoms -> pages -> seed assets -> tests -> analyze/refactor.

## 15. Risks
- AlQuran Cloud shape drift -> isolate in DTO+mappers, contract-test with sample JSON.
- Bundled full mushaf too large -> ship metadata + short surahs, sync rest.
- Freezed/Drift codegen churn -> pin versions, delete-conflicting-outputs.
