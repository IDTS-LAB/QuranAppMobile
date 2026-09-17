// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayah_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AyahDto {

 int get number; String get text; int get numberInSurah; int? get juz; int? get page;
/// Create a copy of AyahDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahDtoCopyWith<AyahDto> get copyWith => _$AyahDtoCopyWithImpl<AyahDto>(this as AyahDto, _$identity);

  /// Serializes this AyahDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AyahDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyahDto&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.numberInSurah, _this.numberInSurah) || other.numberInSurah == _this.numberInSurah)&&(identical(other.juz, _this.juz) || other.juz == _this.juz)&&(identical(other.page, _this.page) || other.page == _this.page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AyahDto;
  return Object.hash(runtimeType,_this.number,_this.text,_this.numberInSurah,_this.juz,_this.page);
}

@override
String toString() {
  final _this = this as AyahDto;
  return 'AyahDto(number: ${_this.number}, text: ${_this.text}, numberInSurah: ${_this.numberInSurah}, juz: ${_this.juz}, page: ${_this.page})';
}


}

/// @nodoc
abstract mixin class $AyahDtoCopyWith<$Res>  {
  factory $AyahDtoCopyWith(AyahDto value, $Res Function(AyahDto) _then) = _$AyahDtoCopyWithImpl;
@useResult
$Res call({
 int number, String text, int numberInSurah, int? juz, int? page
});




}
/// @nodoc
class _$AyahDtoCopyWithImpl<$Res>
    implements $AyahDtoCopyWith<$Res> {
  _$AyahDtoCopyWithImpl(this._self, this._then);

  final AyahDto _self;
  final $Res Function(AyahDto) _then;

/// Create a copy of AyahDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? text = null,Object? numberInSurah = null,Object? juz = freezed,Object? page = freezed,}) {
  return _then(AyahDto(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,numberInSurah: null == numberInSurah ? _self.numberInSurah : numberInSurah // ignore: cast_nullable_to_non_nullable
as int,juz: freezed == juz ? _self.juz : juz // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AyahDto].
extension AyahDtoPatterns on AyahDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AyahDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AyahDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AyahDto value)  $default,){
final _that = this;
switch (_that) {
case _AyahDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AyahDto value)?  $default,){
final _that = this;
switch (_that) {
case _AyahDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String text,  int numberInSurah,  int? juz,  int? page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AyahDto() when $default != null:
return $default(_that.number,_that.text,_that.numberInSurah,_that.juz,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String text,  int numberInSurah,  int? juz,  int? page)  $default,) {final _that = this;
switch (_that) {
case _AyahDto():
return $default(_that.number,_that.text,_that.numberInSurah,_that.juz,_that.page);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String text,  int numberInSurah,  int? juz,  int? page)?  $default,) {final _that = this;
switch (_that) {
case _AyahDto() when $default != null:
return $default(_that.number,_that.text,_that.numberInSurah,_that.juz,_that.page);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AyahDto extends AyahDto {
  const _AyahDto({required this.number, required this.text, required this.numberInSurah, this.juz, this.page}): super._();
  factory _AyahDto.fromJson(Map<String, dynamic> json) => _$AyahDtoFromJson(json);

@override final  int number;
@override final  String text;
@override final  int numberInSurah;
@override final  int? juz;
@override final  int? page;

/// Create a copy of AyahDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahDtoCopyWith<_AyahDto> get copyWith => __$AyahDtoCopyWithImpl<_AyahDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AyahDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AyahDto&&(identical(other.number, number) || other.number == number)&&(identical(other.text, text) || other.text == text)&&(identical(other.numberInSurah, numberInSurah) || other.numberInSurah == numberInSurah)&&(identical(other.juz, juz) || other.juz == juz)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,number,text,numberInSurah,juz,page);
}

@override
String toString() {
    return 'AyahDto(number: $number, text: $text, numberInSurah: $numberInSurah, juz: $juz, page: $page)';
}


}

/// @nodoc
abstract mixin class _$AyahDtoCopyWith<$Res> implements $AyahDtoCopyWith<$Res> {
  factory _$AyahDtoCopyWith(_AyahDto value, $Res Function(_AyahDto) _then) = __$AyahDtoCopyWithImpl;
@override @useResult
$Res call({
 int number, String text, int numberInSurah, int? juz, int? page
});




}
/// @nodoc
class __$AyahDtoCopyWithImpl<$Res>
    implements _$AyahDtoCopyWith<$Res> {
  __$AyahDtoCopyWithImpl(this._self, this._then);

  final _AyahDto _self;
  final $Res Function(_AyahDto) _then;

/// Create a copy of AyahDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? text = null,Object? numberInSurah = null,Object? juz = freezed,Object? page = freezed,}) {
  return _then(_AyahDto(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,numberInSurah: null == numberInSurah ? _self.numberInSurah : numberInSurah // ignore: cast_nullable_to_non_nullable
as int,juz: freezed == juz ? _self.juz : juz // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
