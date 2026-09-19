import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

Surah surahRowToEntity(SurahRow r) => Surah(
  number: r.number,
  arabicName: r.arabicName,
  englishName: r.englishName,
  englishMeaning: r.englishMeaning,
  revelationType: r.revelationType,
  ayahCount: r.ayahCount,
);
