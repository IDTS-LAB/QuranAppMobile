// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Surah {

 int get number; String get arabicName; String get englishName; String get englishMeaning; String get revelationType; int get ayahCount;
/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahCopyWith<Surah> get copyWith => _$SurahCopyWithImpl<Surah>(this as Surah, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Surah;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surah&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.arabicName, _this.arabicName) || other.arabicName == _this.arabicName)&&(identical(other.englishName, _this.englishName) || other.englishName == _this.englishName)&&(identical(other.englishMeaning, _this.englishMeaning) || other.englishMeaning == _this.englishMeaning)&&(identical(other.revelationType, _this.revelationType) || other.revelationType == _this.revelationType)&&(identical(other.ayahCount, _this.ayahCount) || other.ayahCount == _this.ayahCount));
}


@override
int get hashCode {
  final _this = this as Surah;
  return Object.hash(runtimeType,_this.number,_this.arabicName,_this.englishName,_this.englishMeaning,_this.revelationType,_this.ayahCount);
}

@override
String toString() {
  final _this = this as Surah;
  return 'Surah(number: ${_this.number}, arabicName: ${_this.arabicName}, englishName: ${_this.englishName}, englishMeaning: ${_this.englishMeaning}, revelationType: ${_this.revelationType}, ayahCount: ${_this.ayahCount})';
}


}

/// @nodoc
abstract mixin class $SurahCopyWith<$Res>  {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) _then) = _$SurahCopyWithImpl;
@useResult
$Res call({
 int number, String arabicName, String englishName, String englishMeaning, String revelationType, int ayahCount
});




}
/// @nodoc
class _$SurahCopyWithImpl<$Res>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._self, this._then);

  final Surah _self;
  final $Res Function(Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? arabicName = null,Object? englishName = null,Object? englishMeaning = null,Object? revelationType = null,Object? ayahCount = null,}) {
  return _then(Surah(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,englishMeaning: null == englishMeaning ? _self.englishMeaning : englishMeaning // ignore: cast_nullable_to_non_nullable
as String,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Surah].
extension SurahPatterns on Surah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Surah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Surah value)  $default,){
final _that = this;
switch (_that) {
case _Surah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Surah value)?  $default,){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String arabicName,  String englishName,  String englishMeaning,  String revelationType,  int ayahCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.number,_that.arabicName,_that.englishName,_that.englishMeaning,_that.revelationType,_that.ayahCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String arabicName,  String englishName,  String englishMeaning,  String revelationType,  int ayahCount)  $default,) {final _that = this;
switch (_that) {
case _Surah():
return $default(_that.number,_that.arabicName,_that.englishName,_that.englishMeaning,_that.revelationType,_that.ayahCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String arabicName,  String englishName,  String englishMeaning,  String revelationType,  int ayahCount)?  $default,) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.number,_that.arabicName,_that.englishName,_that.englishMeaning,_that.revelationType,_that.ayahCount);case _:
  return null;

}
}

}

/// @nodoc


class _Surah implements Surah {
  const _Surah({required this.number, required this.arabicName, required this.englishName, required this.englishMeaning, required this.revelationType, required this.ayahCount});
  

@override final  int number;
@override final  String arabicName;
@override final  String englishName;
@override final  String englishMeaning;
@override final  String revelationType;
@override final  int ayahCount;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahCopyWith<_Surah> get copyWith => __$SurahCopyWithImpl<_Surah>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surah&&(identical(other.number, number) || other.number == number)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.englishMeaning, englishMeaning) || other.englishMeaning == englishMeaning)&&(identical(other.revelationType, revelationType) || other.revelationType == revelationType)&&(identical(other.ayahCount, ayahCount) || other.ayahCount == ayahCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,number,arabicName,englishName,englishMeaning,revelationType,ayahCount);
}

@override
String toString() {
    return 'Surah(number: $number, arabicName: $arabicName, englishName: $englishName, englishMeaning: $englishMeaning, revelationType: $revelationType, ayahCount: $ayahCount)';
}


}

/// @nodoc
abstract mixin class _$SurahCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$SurahCopyWith(_Surah value, $Res Function(_Surah) _then) = __$SurahCopyWithImpl;
@override @useResult
$Res call({
 int number, String arabicName, String englishName, String englishMeaning, String revelationType, int ayahCount
});




}
/// @nodoc
class __$SurahCopyWithImpl<$Res>
    implements _$SurahCopyWith<$Res> {
  __$SurahCopyWithImpl(this._self, this._then);

  final _Surah _self;
  final $Res Function(_Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? arabicName = null,Object? englishName = null,Object? englishMeaning = null,Object? revelationType = null,Object? ayahCount = null,}) {
  return _then(_Surah(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,englishMeaning: null == englishMeaning ? _self.englishMeaning : englishMeaning // ignore: cast_nullable_to_non_nullable
as String,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
