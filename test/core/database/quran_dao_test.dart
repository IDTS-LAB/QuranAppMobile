import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/database/app_database.dart';

void main() {
  test('upsert + read surahs round-trips', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.quranDao.upsertSurah(
      number: 112,
      arabicName: 'الإخلاص',
      englishName: 'Al-Ikhlas',
      englishMeaning: 'Sincerity',
      revelationType: 'Meccan',
      ayahCount: 4,
    );
    final rows = await db.quranDao.getSurahs();
    expect(rows.length, 1);
    expect(rows.first.englishName, 'Al-Ikhlas');
    await db.close();
  });
}
