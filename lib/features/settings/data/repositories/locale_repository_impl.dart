import 'package:quran_app/core/database/daos/settings_dao.dart';
import 'package:quran_app/core/localization/app_locale.dart';
import 'package:quran_app/features/settings/domain/repositories/locale_repository.dart';

/// Drift-backed locale persistence.
class LocaleRepositoryImpl implements LocaleRepository {
  /// Creates a repository over [dao].
  LocaleRepositoryImpl(this._dao);

  /// Settings key holding the BCP-47 language code.
  static const String localeKey = 'locale';

  final SettingsDao _dao;

  @override
  Future<AppLocale?> getSavedLocale() async {
    final code = await _dao.getSetting(localeKey);
    return AppLocale.fromLanguageCode(code);
  }

  @override
  Future<void> saveLocale(AppLocale? locale) {
    if (locale == null) {
      return _dao.clearSetting(localeKey);
    }
    return _dao.setSetting(localeKey, locale.languageCode);
  }
}
