// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'random_image.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RandomImageModelTearOff {
  const _$RandomImageModelTearOff();

  _RandomImageModel call(
      {required String imageUrl, required bool isSuccessful}) {
    return _RandomImageModel(
      imageUrl: imageUrl,
      isSuccessful: isSuccessful,
    );
  }
}

/// @nodoc
const $RandomImageModel = _$RandomImageModelTearOff();

/// @nodoc
mixin _$RandomImageModel {
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isSuccessful => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RandomImageModelCopyWith<RandomImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomImageModelCopyWith<$Res> {
  factory $RandomImageModelCopyWith(
          RandomImageModel value, $Res Function(RandomImageModel) then) =
      _$RandomImageModelCopyWithImpl<$Res>;
  $Res call({String imageUrl, bool isSuccessful});
}

/// @nodoc
class _$RandomImageModelCopyWithImpl<$Res>
    implements $RandomImageModelCopyWith<$Res> {
  _$RandomImageModelCopyWithImpl(this._value, this._then);

  final RandomImageModel _value;
  // ignore: unused_field
  final $Res Function(RandomImageModel) _then;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? isSuccessful = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccessful: isSuccessful == freezed
          ? _value.isSuccessful
          : isSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RandomImageModelCopyWith<$Res>
    implements $RandomImageModelCopyWith<$Res> {
  factory _$RandomImageModelCopyWith(
          _RandomImageModel value, $Res Function(_RandomImageModel) then) =
      __$RandomImageModelCopyWithImpl<$Res>;
  @override
  $Res call({String imageUrl, bool isSuccessful});
}

/// @nodoc
class __$RandomImageModelCopyWithImpl<$Res>
    extends _$RandomImageModelCopyWithImpl<$Res>
    implements _$RandomImageModelCopyWith<$Res> {
  __$RandomImageModelCopyWithImpl(
      _RandomImageModel _value, $Res Function(_RandomImageModel) _then)
      : super(_value, (v) => _then(v as _RandomImageModel));

  @override
  _RandomImageModel get _value => super._value as _RandomImageModel;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? isSuccessful = freezed,
  }) {
    return _then(_RandomImageModel(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccessful: isSuccessful == freezed
          ? _value.isSuccessful
          : isSuccessful // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_RandomImageModel implements _RandomImageModel {
  _$_RandomImageModel({required this.imageUrl, required this.isSuccessful});

  @override
  final String imageUrl;
  @override
  final bool isSuccessful;

  @override
  String toString() {
    return 'RandomImageModel(imageUrl: $imageUrl, isSuccessful: $isSuccessful)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RandomImageModel &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.isSuccessful, isSuccessful) ||
                const DeepCollectionEquality()
                    .equals(other.isSuccessful, isSuccessful)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(isSuccessful);

  @JsonKey(ignore: true)
  @override
  _$RandomImageModelCopyWith<_RandomImageModel> get copyWith =>
      __$RandomImageModelCopyWithImpl<_RandomImageModel>(this, _$identity);
}

abstract class _RandomImageModel implements RandomImageModel {
  factory _RandomImageModel(
      {required String imageUrl,
      required bool isSuccessful}) = _$_RandomImageModel;

  @override
  String get imageUrl => throw _privateConstructorUsedError;
  @override
  bool get isSuccessful => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RandomImageModelCopyWith<_RandomImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
