import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/app/router/route_names.dart';

void main() {
  test('surah detail route builds correctly', () {
    expect(RouteNames.surahDetail(2), '/surahs/2');
  });
}
