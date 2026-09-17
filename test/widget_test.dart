import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';
import 'package:quran_app/app/bootstrap/app_bootstrap.dart';
import 'package:quran_app/features/quran/presentation/widgets/surah_card.dart';
import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';
import 'package:drift/native.dart';
import 'package:quran_app/core/database/app_database.dart';
import 'package:quran_app/features/quran/data/datasources/local/quran_local_data_source.dart';

void main() {
  setUp(() {
    AppBootstrap.resetForTesting();
  });

  testWidgets('QuranApp boots to the surah list shell', (
    WidgetTester tester,
  ) async {
    // Create an in-memory database and seed with test data
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final local = QuranLocalDataSource(db.quranDao);
    await local.seedSurahs([
      {
        'number': 1,
        'arabicName': 'الفاتحة',
        'englishName': 'Al-Fatiha',
        'englishMeaning': 'The Opener',
        'revelationType': 'Meccan',
        'ayahCount': 7,
      },
      {
        'number': 2,
        'arabicName': 'البقرة',
        'englishName': 'Al-Baqara',
        'englishMeaning': 'The Cow',
        'revelationType': 'Medinan',
        'ayahCount': 286,
      },
    ]);

await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const QuranApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Surahs'), findsNWidgets(2));
    expect(find.byType(SurahCard), findsAtLeast(1));

    // Clean up
    await db.close();
  });
}
