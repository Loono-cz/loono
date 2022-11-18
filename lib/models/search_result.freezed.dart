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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

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
abstract class _$$_SearchResultCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$_SearchResultCopyWith(
          _$_SearchResult value, $Res Function(_$_SearchResult) then) =
      __$$_SearchResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {SearchType searchType,
      String? overriddenText,
      @SimpleHealthcareProviderJsonConverter() SimpleHealthcareProvider? data});
}

/// @nodoc
class __$$_SearchResultCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res>
    implements _$$_SearchResultCopyWith<$Res> {
  __$$_SearchResultCopyWithImpl(
      _$_SearchResult _value, $Res Function(_$_SearchResult) _then)
      : super(_value, (v) => _then(v as _$_SearchResult));

  @override
  _$_SearchResult get _value => super._value as _$_SearchResult;

  @override
  $Res call({
    Object? searchType = freezed,
    Object? overriddenText = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_SearchResult(
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
            other is _$_SearchResult &&
            const DeepCollectionEquality()
                .equals(other.searchType, searchType) &&
            const DeepCollectionEquality()
                .equals(other.overriddenText, overriddenText) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(searchType),
      const DeepCollectionEquality().hash(overriddenText),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_SearchResultCopyWith<_$_SearchResult> get copyWith =>
      __$$_SearchResultCopyWithImpl<_$_SearchResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchResultToJson(
      this,
    );
  }
}

abstract class _SearchResult implements SearchResult {
  factory _SearchResult(
      {required final SearchType searchType,
      final String? overriddenText,
      @SimpleHealthcareProviderJsonConverter()
          required final SimpleHealthcareProvider? data}) = _$_SearchResult;

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
  _$$_SearchResultCopyWith<_$_SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}
