import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
Ayah ayahRowToEntity(AyahRow r) => Ayah(
  surahNumber: r.surahNumber, numberInSurah: r.numberInSurah,
  numberInQuran: r.numberInQuran, arabicText: r.arabicText,
  translation: r.translation, juz: r.juz, page: r.page,
);
