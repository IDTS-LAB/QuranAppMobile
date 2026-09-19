import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/settings_tables.dart';

part 'settings_dao.g.dart';

/// Key-value settings access (locale override today, extensible).
@DriftAccessor(tables: [SettingRows])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  /// Creates a settings DAO.
  SettingsDao(super.db);

  /// Reads the value for [key], or `null` when absent.
  Future<String?> getSetting(String key) async {
    final row = await (select(
      settingRows,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  /// Upserts [value] for [key].
  Future<void> setSetting(String key, String value) => into(settingRows)
      .insertOnConflictUpdate(
        SettingRowsCompanion(key: Value(key), value: Value(value)),
      );

  /// Removes [key] (restores the default behavior).
  Future<void> clearSetting(String key) =>
      (delete(settingRows)..where((t) => t.key.equals(key))).go();
}
