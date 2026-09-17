import 'package:freezed_annotation/freezed_annotation.dart';

part 'ayah.freezed.dart';

@freezed
abstract class Ayah with _$Ayah {
  const factory Ayah({
    required int surahNumber,
    required int numberInSurah,
    int? numberInQuran,
    required String arabicText,
    String? translation,
    int? juz,
    int? page,
  }) = _Ayah;
}
