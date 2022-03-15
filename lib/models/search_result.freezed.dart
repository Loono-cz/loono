// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
class _$SearchResultTearOff {
  const _$SearchResultTearOff();

  _SearchResult call(
      {required SearchType searchType,
      String? overriddenText,
      @SimpleHealthcareProviderJsonConverter()
          required SimpleHealthcareProvider? data}) {
    return _SearchResult(
      searchType: searchType,
      overriddenText: overriddenText,
      data: data,
    );
  }

  SearchResult fromJson(Map<String, Object?> json) {
    return SearchResult.fromJson(json);
  }
}

/// @nodoc
const $SearchResult = _$SearchResultTearOff();

/// @nodoc
mixin _$SearchResult {
  SearchType get searchType => throw _privateConstructorUsedError;
  String? get overriddenText => throw _privateConstructorUsedError;
  @SimpleHealthcareProviderJsonConverter()
  SimpleHealthcareProvider? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) then) =
      _$SearchResultCopyWithImpl<$Res>;
  $Res call(
      {SearchType searchType,
      String? overriddenText,
      @SimpleHealthcareProviderJsonConverter() SimpleHealthcareProvider? data});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res> implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  final SearchResult _value;
  // ignore: unused_field
  final $Res Function(SearchResult) _then;

  @override
  $Res call({
    Object? searchType = freezed,
    Object? overriddenText = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      searchType: searchType == freezed
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      overriddenText: overriddenText == freezed
          ? _value.overriddenText
          : overriddenText // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SimpleHealthcareProvider?,
    ));
  }
}

/// @nodoc
abstract class _$SearchResultCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(
          _SearchResult value, $Res Function(_SearchResult) then) =
      __$SearchResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {SearchType searchType,
      String? overriddenText,
      @SimpleHealthcareProviderJsonConverter() SimpleHealthcareProvider? data});
}

/// @nodoc
class __$SearchResultCopyWithImpl<$Res> extends _$SearchResultCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(
      _SearchResult _value, $Res Function(_SearchResult) _then)
      : super(_value, (v) => _then(v as _SearchResult));

  @override
  _SearchResult get _value => super._value as _SearchResult;

  @override
  $Res call({
    Object? searchType = freezed,
    Object? overriddenText = freezed,
    Object? data = freezed,
  }) {
    return _then(_SearchResult(
      searchType: searchType == freezed
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      overriddenText: overriddenText == freezed
          ? _value.overriddenText
          : overriddenText // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SimpleHealthcareProvider?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchResult implements _SearchResult {
  _$_SearchResult(
      {required this.searchType,
      this.overriddenText,
      @SimpleHealthcareProviderJsonConverter() required this.data});

  factory _$_SearchResult.fromJson(Map<String, dynamic> json) =>
      _$$_SearchResultFromJson(json);

  @override
  final SearchType searchType;
  @override
  final String? overriddenText;
  @override
  @SimpleHealthcareProviderJsonConverter()
  final SimpleHealthcareProvider? data;

  @override
  String toString() {
    return 'SearchResult(searchType: $searchType, overriddenText: $overriddenText, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchResult &&
            const DeepCollectionEquality()
                .equals(other.searchType, searchType) &&
            const DeepCollectionEquality()
                .equals(other.overriddenText, overriddenText) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(searchType),
      const DeepCollectionEquality().hash(overriddenText),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$SearchResultCopyWith<_SearchResult> get copyWith =>
      __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchResultToJson(this);
  }
}

abstract class _SearchResult implements SearchResult {
  factory _SearchResult(
      {required SearchType searchType,
      String? overriddenText,
      @SimpleHealthcareProviderJsonConverter()
          required SimpleHealthcareProvider? data}) = _$_SearchResult;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$_SearchResult.fromJson;

  @override
  SearchType get searchType;
  @override
  String? get overriddenText;
  @override
  @SimpleHealthcareProviderJsonConverter()
  SimpleHealthcareProvider? get data;
  @override
  @JsonKey(ignore: true)
  _$SearchResultCopyWith<_SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}
