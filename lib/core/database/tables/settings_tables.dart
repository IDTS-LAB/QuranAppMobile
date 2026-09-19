import 'package:drift/drift.dart';

/// Key-value application settings (locale override today, extensible).
class SettingRows extends Table {
  /// Setting key (e.g. `locale`).
  TextColumn get key => text()();

  /// Setting value (e.g. `en`).
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
