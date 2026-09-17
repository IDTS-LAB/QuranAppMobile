// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurahDto {

 int get number; String get name; String get englishName; String get englishNameTranslation; String get revelationType; int get numberOfAyahs;
/// Create a copy of SurahDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahDtoCopyWith<SurahDto> get copyWith => _$SurahDtoCopyWithImpl<SurahDto>(this as SurahDto, _$identity);

  /// Serializes this SurahDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SurahDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahDto&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.englishName, _this.englishName) || other.englishName == _this.englishName)&&(identical(other.englishNameTranslation, _this.englishNameTranslation) || other.englishNameTranslation == _this.englishNameTranslation)&&(identical(other.revelationType, _this.revelationType) || other.revelationType == _this.revelationType)&&(identical(other.numberOfAyahs, _this.numberOfAyahs) || other.numberOfAyahs == _this.numberOfAyahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SurahDto;
  return Object.hash(runtimeType,_this.number,_this.name,_this.englishName,_this.englishNameTranslation,_this.revelationType,_this.numberOfAyahs);
}

@override
String toString() {
  final _this = this as SurahDto;
  return 'SurahDto(number: ${_this.number}, name: ${_this.name}, englishName: ${_this.englishName}, englishNameTranslation: ${_this.englishNameTranslation}, revelationType: ${_this.revelationType}, numberOfAyahs: ${_this.numberOfAyahs})';
}


}

/// @nodoc
abstract mixin class $SurahDtoCopyWith<$Res>  {
  factory $SurahDtoCopyWith(SurahDto value, $Res Function(SurahDto) _then) = _$SurahDtoCopyWithImpl;
@useResult
$Res call({
 int number, String name, String englishName, String englishNameTranslation, String revelationType, int numberOfAyahs
});




}
/// @nodoc
class _$SurahDtoCopyWithImpl<$Res>
    implements $SurahDtoCopyWith<$Res> {
  _$SurahDtoCopyWithImpl(this._self, this._then);

  final SurahDto _self;
  final $Res Function(SurahDto) _then;

/// Create a copy of SurahDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? name = null,Object? englishName = null,Object? englishNameTranslation = null,Object? revelationType = null,Object? numberOfAyahs = null,}) {
  return _then(SurahDto(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,englishNameTranslation: null == englishNameTranslation ? _self.englishNameTranslation : englishNameTranslation // ignore: cast_nullable_to_non_nullable
as String,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,numberOfAyahs: null == numberOfAyahs ? _self.numberOfAyahs : numberOfAyahs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahDto].
extension SurahDtoPatterns on SurahDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahDto value)  $default,){
final _that = this;
switch (_that) {
case _SurahDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahDto value)?  $default,){
final _that = this;
switch (_that) {
case _SurahDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String name,  String englishName,  String englishNameTranslation,  String revelationType,  int numberOfAyahs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahDto() when $default != null:
return $default(_that.number,_that.name,_that.englishName,_that.englishNameTranslation,_that.revelationType,_that.numberOfAyahs);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String name,  String englishName,  String englishNameTranslation,  String revelationType,  int numberOfAyahs)  $default,) {final _that = this;
switch (_that) {
case _SurahDto():
return $default(_that.number,_that.name,_that.englishName,_that.englishNameTranslation,_that.revelationType,_that.numberOfAyahs);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String name,  String englishName,  String englishNameTranslation,  String revelationType,  int numberOfAyahs)?  $default,) {final _that = this;
switch (_that) {
case _SurahDto() when $default != null:
return $default(_that.number,_that.name,_that.englishName,_that.englishNameTranslation,_that.revelationType,_that.numberOfAyahs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurahDto extends SurahDto {
  const _SurahDto({required this.number, required this.name, required this.englishName, required this.englishNameTranslation, required this.revelationType, required this.numberOfAyahs}): super._();
  factory _SurahDto.fromJson(Map<String, dynamic> json) => _$SurahDtoFromJson(json);

@override final  int number;
@override final  String name;
@override final  String englishName;
@override final  String englishNameTranslation;
@override final  String revelationType;
@override final  int numberOfAyahs;

/// Create a copy of SurahDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahDtoCopyWith<_SurahDto> get copyWith => __$SurahDtoCopyWithImpl<_SurahDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahDto&&(identical(other.number, number) || other.number == number)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.englishNameTranslation, englishNameTranslation) || other.englishNameTranslation == englishNameTranslation)&&(identical(other.revelationType, revelationType) || other.revelationType == revelationType)&&(identical(other.numberOfAyahs, numberOfAyahs) || other.numberOfAyahs == numberOfAyahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,number,name,englishName,englishNameTranslation,revelationType,numberOfAyahs);
}

@override
String toString() {
    return 'SurahDto(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, revelationType: $revelationType, numberOfAyahs: $numberOfAyahs)';
}


}

/// @nodoc
abstract mixin class _$SurahDtoCopyWith<$Res> implements $SurahDtoCopyWith<$Res> {
  factory _$SurahDtoCopyWith(_SurahDto value, $Res Function(_SurahDto) _then) = __$SurahDtoCopyWithImpl;
@override @useResult
$Res call({
 int number, String name, String englishName, String englishNameTranslation, String revelationType, int numberOfAyahs
});




}
/// @nodoc
class __$SurahDtoCopyWithImpl<$Res>
    implements _$SurahDtoCopyWith<$Res> {
  __$SurahDtoCopyWithImpl(this._self, this._then);

  final _SurahDto _self;
  final $Res Function(_SurahDto) _then;

/// Create a copy of SurahDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? name = null,Object? englishName = null,Object? englishNameTranslation = null,Object? revelationType = null,Object? numberOfAyahs = null,}) {
  return _then(_SurahDto(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,englishNameTranslation: null == englishNameTranslation ? _self.englishNameTranslation : englishNameTranslation // ignore: cast_nullable_to_non_nullable
as String,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,numberOfAyahs: null == numberOfAyahs ? _self.numberOfAyahs : numberOfAyahs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
