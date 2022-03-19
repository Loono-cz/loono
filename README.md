# loono

We show prevention matters.

- To generate the freezed or db part files run `flutter packages pub run build_runner build --delete-conflicting-outputs`.
- If you need to define anything non static on a freezed class remember to add a private constructor (https://pub.dev/packages/freezed#custom-getters-and-methods)
- You might need to rerun the Dart Analyser for the IDE to be pick up the generated files

Notes

- We are committing generated files to avoid situations where those files might be different among
  developers or might differ from the ones generated via the CodeMagic pipeline. We also commit them to
  avoid spending time and money when building the app on CodeMagic.

## App internalizations

- Currently app supports only Czech language, all texts used within the app should be located in `lib/l10n/intl_cs.arb`. Supporting new languages can be made by adding new language arb file.
- Internalization is done by [flutter_internalization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) plugin

## Integration Tests
- **Make sure to <ins>clear the app's</ins> data before running the tests.** (Android)
- To run all tests on an emulator or on a real iOS / Android device, first connect the device and run the following command from the root of the project:
`flutter test integration_test --test-randomize-ordering-seed=random --flavor dev`
- Or, you can run a specific TC or a group with:
`flutter test integration_test\test_sets\app_test.dart --plain-name "TC(LOON_437): Logout (straight path)" --flavor dev`
- Since the app is in active development, tests are expected to fail often. No need to fix them right away.
- Conventions:
    - test case implementation is inspired by POM (Page Object Model) design pattern
    - test data are created from Dart objects and not from JSON - for easier maintainability from API changes
    - test cases are structured with folder-by-feature