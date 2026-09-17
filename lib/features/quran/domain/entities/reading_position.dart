import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_position.freezed.dart';

@freezed
abstract class ReadingPosition with _$ReadingPosition {
  const factory ReadingPosition({
    required int surahNumber,
    required int ayahNumber,
    required DateTime updatedAt,
  }) = _ReadingPosition;
}
