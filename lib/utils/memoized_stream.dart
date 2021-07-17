import 'dart:async';

import 'package:flutter/material.dart';

class MemoizedStream<T> {
  late T lastItem;
  final Stream<T> stream;

  MemoizedStream(Stream<T> inputStream) : stream = inputStream.asBroadcastStream() {
    stream.listen((newItem) => lastItem = newItem);
  }
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
            key: key);
}
