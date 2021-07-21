import 'package:flutter/material.dart';
import 'package:loono/utils/provider_utils.dart';
import 'package:loono/utils/theme_utils.dart';
import 'package:loono/dtos/breed_api/breeds.dart';
import 'package:loono/screens/example/example.notifier.dart';
import 'package:loono/screens/screen_names.dart';
import 'package:loono/services/breed.service.dart';
import 'package:loono/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class ExampleScreen extends StatelessWidget {
  @visibleForTesting
  const ExampleScreen({
    required this.notifier,
    Key? key,
  }) : super(key: key);

  final ExampleNotifier notifier;

  static Page<Object> buildPage(BuildContext context, {Breed? breed}) {
    return MaterialPage(
      key: const ValueKey(ScreenNames.exampleScreen),
      name: ScreenNames.exampleScreen,
      child: InsertNotifier<ExampleNotifier>(
        notifierBuilder: (context) {
          return ExampleNotifier(
            context.read<BreedService>(),
            breed: breed,
          );
        },
        childBuilder: (context, notifier) {
          return ExampleScreen(
            notifier: context.read<ExampleNotifier>(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final breed = notifier.breed;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          breed == null ? 'Random' : breed.prettyString,
        ),
        actions: [
          IconButton(
            onPressed: notifier.fetchImage,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: Listen<ExampleNotifier>(
          builder: (_) {
            final result = notifier.result;

            if (result.hasError || result.isNotInitialised) {
              return const Text('Check your internet connection');
            }

            if (result.isLoading) {
              return const LoadingIndicator();
            }

            final url = result.data;

            if (url == null || url.isEmpty) {
              return const Text('Something went wrong');
            }

            return Padding(
              padding: paddingEdges,
              child: Image.network(url),
            );
          },
        ),
      ),
    );
  }
}
