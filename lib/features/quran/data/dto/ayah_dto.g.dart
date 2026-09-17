// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AyahDto _$AyahDtoFromJson(Map<String, dynamic> json) => _AyahDto(
  number: (json['number'] as num).toInt(),
  text: json['text'] as String,
  numberInSurah: (json['numberInSurah'] as num).toInt(),
  juz: (json['juz'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
);

Map<String, dynamic> _$AyahDtoToJson(_AyahDto instance) => <String, dynamic>{
  'number': instance.number,
  'text': instance.text,
  'numberInSurah': instance.numberInSurah,
  'juz': instance.juz,
  'page': instance.page,
};
