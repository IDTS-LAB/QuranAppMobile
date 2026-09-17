import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

@freezed
abstract class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int surahNumber,
    required int ayahNumber,
    required DateTime createdAt,
  }) = _Bookmark;
}
