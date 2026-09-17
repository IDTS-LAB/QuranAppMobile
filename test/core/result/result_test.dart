// test/core/result/result_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/errors/app_exception.dart';
import 'package:quran_app/core/result/result.dart';

void main() {
  test('Result success maps value', () {
    const Result<int> r = Result.success(2);
    expect(r.map((v) => v * 2), const Result.success(4));
  });
  test('Result failure keeps exception', () {
    const e = NetworkException('offline');
    const Result<int> r = Result.failure(e);
    expect(r.exceptionOrNull(), e);
  });
}
