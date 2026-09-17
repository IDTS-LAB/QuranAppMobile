import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah.freezed.dart';

@freezed
abstract class Surah with _$Surah {
  const factory Surah({
    required int number,
    required String arabicName,
    required String englishName,
    required String englishMeaning,
    required String revelationType,
    required int ayahCount,
  }) = _Surah;
}
