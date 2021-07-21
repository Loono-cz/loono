- To generate the json part files run `flutter packages pub run build_runner build --delete-conflicting-outputs`.
- If you don't need to generate the `toJson` method set `createToJson` to `false` in the `JsonSerializable` annotation.
- You might need to rerun the Dart Analyser for the IDE to be pick up the generated files

Notes
- We are committing generated files to avoid situations where those files might be different among 
developers or might differ from the ones generated via the CodeMagic pipeline. We also commit them to
avoid spending time and money when building the app on CodeMagic.