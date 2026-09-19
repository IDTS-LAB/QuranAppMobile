import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/data/datasources/local/quran_local_data_source.dart';

/// One-time startup work: ensures bindings exist and seeds the Drift
/// database from `assets/quran/surahs.json` on first launch.
abstract final class AppBootstrap {
  static const String seedAssetPath = 'assets/quran/surahs.json';

  static bool _initialized = false;

  /// Runs startup initialization. Safe to call once; subsequent calls
  /// are no-ops. Never throws — seeding failures are reported via
  /// [debugPrint] so a corrupt/missing seed never blocks launch.
  static Future<void> init({AppDatabase? database, AssetBundle? bundle}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (_initialized) {
      return;
    }
    _initialized = true;
    final AppDatabase db = database ?? AppDatabase();
    final bool ownsDatabase = database == null;
    try {
      final QuranLocalDataSource local = QuranLocalDataSource(db.quranDao);
      final List<SurahRow> existing = await local.getSurahs();
      if (existing.isNotEmpty) {
        return;
      }
      final AssetBundle assets = bundle ?? rootBundle;
      final String raw = await assets.loadString(seedAssetPath);
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      final List<Map<String, Object?>> rows = <Map<String, Object?>>[
        for (final dynamic entry in decoded) entry as Map<String, Object?>,
      ];
      await local.seedSurahs(rows);
    } on Exception catch (error) {
      debugPrint('AppBootstrap seed failed: $error');
    } finally {
      if (ownsDatabase) {
        await db.close();
      }
    }
  }

  /// Resets initialization state. Test-only hook.
  @visibleForTesting
  static void resetForTesting() {
    _initialized = false;
  }
}
