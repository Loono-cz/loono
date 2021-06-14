import 'package:flutter/material.dart';
import 'package:loono/core/app_config.dart';
import 'package:loono/core/app_flavor.dart';
import 'package:loono/utils/theme_utils.dart';
import 'package:loono/dtos/example_api/breeds.dart';
import 'package:loono/screens/example/example.screen.dart';
import 'package:loono/screens/screen_names.dart';
import 'package:loono/screens/screen_navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @visibleForTesting
  const HomeScreen({
    required this.config,
    Key? key,
  }) : super(key: key);

  final AppConfig config;

  static Page<Object> buildPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey(ScreenNames.homeScreen),
      name: ScreenNames.homeScreen,
      child: HomeScreen(
        config: context.read<AppConfig>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final env = config.flavor.map(
      prod: () => 'PROD',
      dev: () => 'DEV',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Loono [$env]'),
      ),
      body: Center(
        child: Padding(
          padding: paddingEdges,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScreenNavigator.of(context).push(
                    ExampleScreen.buildPage(context),
                  );
                },
                child: const Text('Random'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScreenNavigator.of(context).push(
                    ExampleScreen.buildPage(
                      context,
                      breed: Breed.germanShepherd,
                    ),
                  );
                },
                child: Text(Breed.germanShepherd.prettyString),
              ),
              ElevatedButton(
                onPressed: () {
                  ScreenNavigator.of(context).push(
                    ExampleScreen.buildPage(
                      context,
                      breed: Breed.husky,
                    ),
                  );
                },
                child: Text(Breed.husky.prettyString),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
