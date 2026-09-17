// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Ayah {

 int get surahNumber; int get numberInSurah; int? get numberInQuran; String get arabicText; String? get translation; int? get juz; int? get page;
/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahCopyWith<Ayah> get copyWith => _$AyahCopyWithImpl<Ayah>(this as Ayah, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Ayah;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ayah&&(identical(other.surahNumber, _this.surahNumber) || other.surahNumber == _this.surahNumber)&&(identical(other.numberInSurah, _this.numberInSurah) || other.numberInSurah == _this.numberInSurah)&&(identical(other.numberInQuran, _this.numberInQuran) || other.numberInQuran == _this.numberInQuran)&&(identical(other.arabicText, _this.arabicText) || other.arabicText == _this.arabicText)&&(identical(other.translation, _this.translation) || other.translation == _this.translation)&&(identical(other.juz, _this.juz) || other.juz == _this.juz)&&(identical(other.page, _this.page) || other.page == _this.page));
}


@override
int get hashCode {
  final _this = this as Ayah;
  return Object.hash(runtimeType,_this.surahNumber,_this.numberInSurah,_this.numberInQuran,_this.arabicText,_this.translation,_this.juz,_this.page);
}

@override
String toString() {
  final _this = this as Ayah;
  return 'Ayah(surahNumber: ${_this.surahNumber}, numberInSurah: ${_this.numberInSurah}, numberInQuran: ${_this.numberInQuran}, arabicText: ${_this.arabicText}, translation: ${_this.translation}, juz: ${_this.juz}, page: ${_this.page})';
}


}

/// @nodoc
abstract mixin class $AyahCopyWith<$Res>  {
  factory $AyahCopyWith(Ayah value, $Res Function(Ayah) _then) = _$AyahCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int numberInSurah, int? numberInQuran, String arabicText, String? translation, int? juz, int? page
});




}
/// @nodoc
class _$AyahCopyWithImpl<$Res>
    implements $AyahCopyWith<$Res> {
  _$AyahCopyWithImpl(this._self, this._then);

  final Ayah _self;
  final $Res Function(Ayah) _then;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? numberInSurah = null,Object? numberInQuran = freezed,Object? arabicText = null,Object? translation = freezed,Object? juz = freezed,Object? page = freezed,}) {
  return _then(Ayah(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,numberInSurah: null == numberInSurah ? _self.numberInSurah : numberInSurah // ignore: cast_nullable_to_non_nullable
as int,numberInQuran: freezed == numberInQuran ? _self.numberInQuran : numberInQuran // ignore: cast_nullable_to_non_nullable
as int?,arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,juz: freezed == juz ? _self.juz : juz // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ayah].
extension AyahPatterns on Ayah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ayah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ayah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ayah value)  $default,){
final _that = this;
switch (_that) {
case _Ayah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ayah value)?  $default,){
final _that = this;
switch (_that) {
case _Ayah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int numberInSurah,  int? numberInQuran,  String arabicText,  String? translation,  int? juz,  int? page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ayah() when $default != null:
return $default(_that.surahNumber,_that.numberInSurah,_that.numberInQuran,_that.arabicText,_that.translation,_that.juz,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int numberInSurah,  int? numberInQuran,  String arabicText,  String? translation,  int? juz,  int? page)  $default,) {final _that = this;
switch (_that) {
case _Ayah():
return $default(_that.surahNumber,_that.numberInSurah,_that.numberInQuran,_that.arabicText,_that.translation,_that.juz,_that.page);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int numberInSurah,  int? numberInQuran,  String arabicText,  String? translation,  int? juz,  int? page)?  $default,) {final _that = this;
switch (_that) {
case _Ayah() when $default != null:
return $default(_that.surahNumber,_that.numberInSurah,_that.numberInQuran,_that.arabicText,_that.translation,_that.juz,_that.page);case _:
  return null;

}
}

}

/// @nodoc


class _Ayah implements Ayah {
  const _Ayah({required this.surahNumber, required this.numberInSurah, this.numberInQuran, required this.arabicText, this.translation, this.juz, this.page});
  

@override final  int surahNumber;
@override final  int numberInSurah;
@override final  int? numberInQuran;
@override final  String arabicText;
@override final  String? translation;
@override final  int? juz;
@override final  int? page;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahCopyWith<_Ayah> get copyWith => __$AyahCopyWithImpl<_Ayah>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ayah&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.numberInSurah, numberInSurah) || other.numberInSurah == numberInSurah)&&(identical(other.numberInQuran, numberInQuran) || other.numberInQuran == numberInQuran)&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.juz, juz) || other.juz == juz)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surahNumber,numberInSurah,numberInQuran,arabicText,translation,juz,page);
}

@override
String toString() {
    return 'Ayah(surahNumber: $surahNumber, numberInSurah: $numberInSurah, numberInQuran: $numberInQuran, arabicText: $arabicText, translation: $translation, juz: $juz, page: $page)';
}


}

/// @nodoc
abstract mixin class _$AyahCopyWith<$Res> implements $AyahCopyWith<$Res> {
  factory _$AyahCopyWith(_Ayah value, $Res Function(_Ayah) _then) = __$AyahCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int numberInSurah, int? numberInQuran, String arabicText, String? translation, int? juz, int? page
});




}
/// @nodoc
class __$AyahCopyWithImpl<$Res>
    implements _$AyahCopyWith<$Res> {
  __$AyahCopyWithImpl(this._self, this._then);

  final _Ayah _self;
  final $Res Function(_Ayah) _then;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? numberInSurah = null,Object? numberInQuran = freezed,Object? arabicText = null,Object? translation = freezed,Object? juz = freezed,Object? page = freezed,}) {
  return _then(_Ayah(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,numberInSurah: null == numberInSurah ? _self.numberInSurah : numberInSurah // ignore: cast_nullable_to_non_nullable
as int,numberInQuran: freezed == numberInQuran ? _self.numberInQuran : numberInQuran // ignore: cast_nullable_to_non_nullable
as int?,arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,juz: freezed == juz ? _self.juz : juz // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
