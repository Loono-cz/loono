import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsertNotifier<T extends ChangeNotifier> extends StatelessWidget {
  const InsertNotifier({
    required this.notifierBuilder,
    required this.childBuilder,
    Key? key,
  }) : super(key: key);

  final Create<T> notifierBuilder;
  final Widget Function(BuildContext context, T value) childBuilder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: notifierBuilder,
      child: Builder(
        builder: (context) {
          return childBuilder(
            context,
            context.read<T>(),
          );
        },
      ),
    );
  }
}

class Listen<T extends ChangeNotifier> extends StatelessWidget {
  const Listen({required this.builder, Key? key}) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    context.watch<T>();
    return builder(context);
  }
}
