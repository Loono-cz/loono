import 'package:flutter/cupertino.dart';
import 'package:loono/core/http/api_exception.dart';

@immutable
class MaybeFailure<T extends Object> {
  const MaybeFailure.failure(ApiException failure)
      : _failure = failure,
        _value = null;

  const MaybeFailure.success(T right)
      : _failure = null,
        _value = right;

  final ApiException? _failure;

  final T? _value;

  bool get hasFailure => _failure != null;

  bool get hasValue => _value != null;

  T get value {
    if (hasFailure) {
      throw NoValuePresentError();
    }

    return _value!;
  }

  ApiException get failure {
    if (hasValue) {
      throw NoFailurePresentError();
    }

    return _failure!;
  }

  S fold<S>({
    required S Function(ApiException) onFailure,
    required S Function(T) onValue,
  }) {
    if (hasFailure) {
      return onFailure(_failure!);
    }

    return onValue(_value!);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MaybeFailure &&
            runtimeType == other.runtimeType &&
            _failure == other._failure &&
            _value == other._value;
  }

  @override
  int get hashCode {
    return _failure.hashCode ^ _value.hashCode;
  }

  @override
  String toString() {
    return 'MaybeFailure{_failure: $_failure, _value: $_value}';
  }
}

class NoValuePresentError extends StateError {
  NoValuePresentError() : super('No value present');
}

class NoFailurePresentError extends StateError {
  NoFailurePresentError() : super('No failure present');
}
