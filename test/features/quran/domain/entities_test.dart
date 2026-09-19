import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

void main() {
  test('Surah entity holds fields', () {
    const s = Surah(
      number: 1,
      arabicName: 'الفاتحة',
      englishName: 'Al-Fatiha',
      englishMeaning: 'The Opener',
      revelationType: 'Meccan',
      ayahCount: 7,
    );
    expect(s.ayahCount, 7);
  });
}
