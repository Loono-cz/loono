import 'dart:async';

import 'package:flutter/material.dart';

typedef OnStateChanged<T> = void Function(T state);

class MemoizedStream<T> {
  MemoizedStream(Stream<T> inputStream) : stream = inputStream.asBroadcastStream() {
    stream.listen((newItem) => lastItem = newItem);
  }

  T? lastItem;
  final Stream<T> stream;
}

class MemoizedStreamBuilder<T> extends StreamBuilder<T> {
  MemoizedStreamBuilder({
    Key? key,
    required MemoizedStream<T> memoizedStream,
    required Widget Function(BuildContext, AsyncSnapshot<T>) builder,
  }) : super(
          builder: builder,
          initialData: memoizedStream.lastItem,
          stream: memoizedStream.stream,
          key: key,
        );
}

class MemoryStorage<T> {
  MemoryStorage({T? withInitialValue, this.onStateChanged}) {
    stateStream = MemoizedStream(_stateController.stream);
    if (withInitialValue != null) setState(withInitialValue);
  }

  final _stateController = StreamController<T>.broadcast();
  final OnStateChanged<T>? onStateChanged;

  late final MemoizedStream<T> stateStream;

  /// The current (latest) state of the [MemoryStorage].
  T? get state => stateStream.lastItem;

  void setState(T newState) {
    _stateController.add(newState);
    onStateChanged?.call(newState);
  }
}
