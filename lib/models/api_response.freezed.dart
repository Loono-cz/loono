// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(DioError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessApiResponse<T> value) success,
    required TResult Function(FailureApiResponse<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) then) =
      _$ApiResponseCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  final ApiResponse<T> _value;
  // ignore: unused_field
  final $Res Function(ApiResponse<T>) _then;
}

/// @nodoc
abstract class _$$SuccessApiResponseCopyWith<T, $Res> {
  factory _$$SuccessApiResponseCopyWith(_$SuccessApiResponse<T> value,
          $Res Function(_$SuccessApiResponse<T>) then) =
      __$$SuccessApiResponseCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$$SuccessApiResponseCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res>
    implements _$$SuccessApiResponseCopyWith<T, $Res> {
  __$$SuccessApiResponseCopyWithImpl(_$SuccessApiResponse<T> _value,
      $Res Function(_$SuccessApiResponse<T>) _then)
      : super(_value, (v) => _then(v as _$SuccessApiResponse<T>));

  @override
  _$SuccessApiResponse<T> get _value => super._value as _$SuccessApiResponse<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessApiResponse<T>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessApiResponse<T> extends SuccessApiResponse<T> {
  const _$SuccessApiResponse(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessApiResponse<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$SuccessApiResponseCopyWith<T, _$SuccessApiResponse<T>> get copyWith =>
      __$$SuccessApiResponseCopyWithImpl<T, _$SuccessApiResponse<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(DioError error) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessApiResponse<T> value) success,
    required TResult Function(FailureApiResponse<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SuccessApiResponse<T> extends ApiResponse<T> {
  const factory SuccessApiResponse(final T data) = _$SuccessApiResponse<T>;
  const SuccessApiResponse._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$SuccessApiResponseCopyWith<T, _$SuccessApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureApiResponseCopyWith<T, $Res> {
  factory _$$FailureApiResponseCopyWith(_$FailureApiResponse<T> value,
          $Res Function(_$FailureApiResponse<T>) then) =
      __$$FailureApiResponseCopyWithImpl<T, $Res>;
  $Res call({DioError error});
}

/// @nodoc
class __$$FailureApiResponseCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res>
    implements _$$FailureApiResponseCopyWith<T, $Res> {
  __$$FailureApiResponseCopyWithImpl(_$FailureApiResponse<T> _value,
      $Res Function(_$FailureApiResponse<T>) _then)
      : super(_value, (v) => _then(v as _$FailureApiResponse<T>));

  @override
  _$FailureApiResponse<T> get _value => super._value as _$FailureApiResponse<T>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$FailureApiResponse<T>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DioError,
    ));
  }
}

/// @nodoc

class _$FailureApiResponse<T> extends FailureApiResponse<T> {
  const _$FailureApiResponse(this.error) : super._();

  @override
  final DioError error;

  @override
  String toString() {
    return 'ApiResponse<$T>.failure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureApiResponse<T> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$FailureApiResponseCopyWith<T, _$FailureApiResponse<T>> get copyWith =>
      __$$FailureApiResponseCopyWithImpl<T, _$FailureApiResponse<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(DioError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(DioError error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessApiResponse<T> value) success,
    required TResult Function(FailureApiResponse<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessApiResponse<T> value)? success,
    TResult Function(FailureApiResponse<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureApiResponse<T> extends ApiResponse<T> {
  const factory FailureApiResponse(final DioError error) =
      _$FailureApiResponse<T>;
  const FailureApiResponse._() : super._();

  DioError get error;
  @JsonKey(ignore: true)
  _$$FailureApiResponseCopyWith<T, _$FailureApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
