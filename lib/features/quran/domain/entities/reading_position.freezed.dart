// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadingPosition {

 int get surahNumber; int get ayahNumber; DateTime get updatedAt;
/// Create a copy of ReadingPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingPositionCopyWith<ReadingPosition> get copyWith => _$ReadingPositionCopyWithImpl<ReadingPosition>(this as ReadingPosition, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReadingPosition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingPosition&&(identical(other.surahNumber, _this.surahNumber) || other.surahNumber == _this.surahNumber)&&(identical(other.ayahNumber, _this.ayahNumber) || other.ayahNumber == _this.ayahNumber)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as ReadingPosition;
  return Object.hash(runtimeType,_this.surahNumber,_this.ayahNumber,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ReadingPosition;
  return 'ReadingPosition(surahNumber: ${_this.surahNumber}, ayahNumber: ${_this.ayahNumber}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ReadingPositionCopyWith<$Res>  {
  factory $ReadingPositionCopyWith(ReadingPosition value, $Res Function(ReadingPosition) _then) = _$ReadingPositionCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int ayahNumber, DateTime updatedAt
});




}
/// @nodoc
class _$ReadingPositionCopyWithImpl<$Res>
    implements $ReadingPositionCopyWith<$Res> {
  _$ReadingPositionCopyWithImpl(this._self, this._then);

  final ReadingPosition _self;
  final $Res Function(ReadingPosition) _then;

/// Create a copy of ReadingPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? updatedAt = null,}) {
  return _then(ReadingPosition(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingPosition].
extension ReadingPositionPatterns on ReadingPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingPosition value)  $default,){
final _that = this;
switch (_that) {
case _ReadingPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingPosition value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingPosition() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReadingPosition():
return $default(_that.surahNumber,_that.ayahNumber,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int ayahNumber,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReadingPosition() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ReadingPosition implements ReadingPosition {
  const _ReadingPosition({required this.surahNumber, required this.ayahNumber, required this.updatedAt});
  

@override final  int surahNumber;
@override final  int ayahNumber;
@override final  DateTime updatedAt;

/// Create a copy of ReadingPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingPositionCopyWith<_ReadingPosition> get copyWith => __$ReadingPositionCopyWithImpl<_ReadingPosition>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingPosition&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surahNumber,ayahNumber,updatedAt);
}

@override
String toString() {
    return 'ReadingPosition(surahNumber: $surahNumber, ayahNumber: $ayahNumber, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReadingPositionCopyWith<$Res> implements $ReadingPositionCopyWith<$Res> {
  factory _$ReadingPositionCopyWith(_ReadingPosition value, $Res Function(_ReadingPosition) _then) = __$ReadingPositionCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int ayahNumber, DateTime updatedAt
});




}
/// @nodoc
class __$ReadingPositionCopyWithImpl<$Res>
    implements _$ReadingPositionCopyWith<$Res> {
  __$ReadingPositionCopyWithImpl(this._self, this._then);

  final _ReadingPosition _self;
  final $Res Function(_ReadingPosition) _then;

/// Create a copy of ReadingPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? updatedAt = null,}) {
  return _then(_ReadingPosition(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
