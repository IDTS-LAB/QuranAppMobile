import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/app.dart';

void main() {
  testWidgets('QuranApp boots to the surah list shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: QuranApp()));
    await tester.pumpAndSettle();

    expect(find.text('Surahs'), findsWidgets);
    expect(find.text('Surah list'), findsOneWidget);
  });
}
