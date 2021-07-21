import 'package:flutter/cupertino.dart';

enum _Result { notInitialised, loading, success, error }

extension _ResultExt on _Result {
  bool get isSuccessful => this == _Result.success;

  bool get isLoading => this == _Result.loading;

  bool get hasError => this == _Result.error;

  bool get isNotInitialised => this == _Result.notInitialised;
}

@immutable
class Result<T> {
  const Result({
    _Result? state,
    this.data,
    this.message,
  }) : state = state ?? _Result.notInitialised;

  const Result.loading({
    this.data,
    this.message,
  }) : state = _Result.loading;

  const Result.success({
    this.data,
    this.message,
  }) : state = _Result.success;

  const Result.error({
    this.data,
    this.message,
  }) : state = _Result.error;

  final _Result state;
  final T? data;
  final String? message;

  bool get isSuccessful => state.isSuccessful;

  bool get isLoading => state.isLoading;

  bool get hasError => state.hasError;

  bool get isNotInitialised => state.isNotInitialised;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Result &&
            runtimeType == other.runtimeType &&
            state == other.state &&
            data == other.data;
  }

  @override
  int get hashCode {
    return state.hashCode ^ data.hashCode;
  }

  @override
  String toString() {
    return 'Result{state: $state, data: $data}';
  }
}
