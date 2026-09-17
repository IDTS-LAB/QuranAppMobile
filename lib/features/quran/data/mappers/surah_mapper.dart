import '../../../../core/database/app_database.dart';
import '../../domain/entities/surah.dart';
Surah surahRowToEntity(SurahRow r) => Surah(
  number: r.number, arabicName: r.arabicName, englishName: r.englishName,
  englishMeaning: r.englishMeaning, revelationType: r.revelationType,
  ayahCount: r.ayahCount,
);
