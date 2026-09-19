// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SettingRowsTable get settingRows => attachedDatabase.settingRows;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$SettingRowsTableTableManager get settingRows =>
      $$SettingRowsTableTableManager(_db.attachedDatabase, _db.settingRows);
}
