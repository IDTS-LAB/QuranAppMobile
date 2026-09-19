import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';
part 'ayah_dto.freezed.dart';
part 'ayah_dto.g.dart';

@freezed
abstract class AyahDto with _$AyahDto {
  const AyahDto._();
  const factory AyahDto({
    required int number,
    required String text,
    required int numberInSurah,
    int? juz,
    int? page,
  }) = _AyahDto;
  factory AyahDto.fromJson(Map<String, Object?> json) =>
      _$AyahDtoFromJson(json);
  Ayah toEntity({required int surahNumber, String? translation}) => Ayah(
    surahNumber: surahNumber,
    numberInSurah: numberInSurah,
    numberInQuran: number,
    arabicText: text,
    translation: translation,
    juz: juz,
    page: page,
  );
}
