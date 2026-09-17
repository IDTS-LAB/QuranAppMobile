import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';
part 'surah_dto.freezed.dart';
part 'surah_dto.g.dart';

@freezed
abstract class SurahDto with _$SurahDto {
  const SurahDto._();
  const factory SurahDto({
    required int number,
    required String name,
    required String englishName,
    required String englishNameTranslation,
    required String revelationType,
    required int numberOfAyahs,
  }) = _SurahDto;
  factory SurahDto.fromJson(Map<String, Object?> json) => _$SurahDtoFromJson(json);
  Surah toEntity() => Surah(
    number: number, arabicName: name, englishName: englishName,
    englishMeaning: englishNameTranslation, revelationType: revelationType,
    ayahCount: numberOfAyahs,
  );
}
