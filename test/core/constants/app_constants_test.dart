import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/constants/app_constants.dart';

void main() {
  test('api constants are exact', () {
    expect(AppConstants.apiBaseUrl, 'https://api.alquran.cloud/v1');
    expect(AppConstants.translationEdition, 'en.sahih');
    expect(AppConstants.connectTimeoutMs, 10000);
  });
}
