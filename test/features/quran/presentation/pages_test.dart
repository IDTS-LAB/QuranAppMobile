import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/widgets/empty/app_empty_view.dart';

void main() {
  testWidgets('empty view shows message', (t) async {
    await t.pumpWidget(const MaterialApp(
        home: AppEmptyView(message: 'No bookmarks yet')));
    expect(find.text('No bookmarks yet'), findsOneWidget);
  });
}
