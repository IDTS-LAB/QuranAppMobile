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
