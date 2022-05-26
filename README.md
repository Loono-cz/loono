# loono

We show prevention matters.

- To generate the freezed or db part files run `flutter packages pub run build_runner build --delete-conflicting-outputs`.
- If you need to define anything non static on a freezed class remember to add a private constructor (https://pub.dev/packages/freezed#custom-getters-and-methods)
- You might need to rerun the Dart Analyser for the IDE to be pick up the generated files

Notes

- We are committing generated files to avoid situations where those files might be different among
  developers or might differ from the ones generated via the CodeMagic pipeline. We also commit them to
  avoid spending time and money when building the app on CodeMagic.

### Mason templates
- [Mason](https://pub.dev/packages/mason_cli) is Dart template generator which helps teams generate files quickly and consistently.
- To install mason, run: `dart pub global activate mason_cli`
- Currently used templates (bricks):
    - pom_class - A template for generating Page Object Model (POM) class.
- Then from the root of the project you can quickly make generate a file from a template:
```
mason get
mason list
mason make pom_class
```

## App internalizations

- Currently app supports only Czech language, all texts used within the app should be located in `lib/l10n/intl_cs.arb`. Supporting new languages can be made by adding new language arb file.
- Internalization is done by [flutter_internalization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) plugin

## Integration Tests
- The app has to run from the clean state. **Make sure to <ins>clear the app's</ins> data before running the tests.** (Android/iOS)
- To run all frontend (UI) tests on an emulator or on a real iOS / Android device, first connect the device and run the following command from the root of the project:
`flutter test --test-randomize-ordering-seed=random --flavor dev integration_test/test_sets/app_test.dart`.
- Or, you can run a specific TC (test case) or a group with:
`flutter test integration_test/test_sets/app_test.dart --plain-name "LOON-437" --flavor dev`
- To run BE tests which test real API, add generated `CUSTOM_TOKEN` to `./assets/.env`. You can run the test then with: `flutter test --flavor dev integration_test/test_sets/be_test.dart`. Generating [Custom Token](https://firebase.google.com/docs/auth/admin/create-custom-tokens) requires having Python SDK & an internal [Firebase Account Service JSON](https://firebase.google.com/docs/auth/admin/create-custom-tokens#using_a_service_account_json_file) file (dev environment).
- Conventions:
    - test case implementation is inspired by POM (Page Object Model) design pattern
    - test data are created from Dart objects and not from JSON - for easier maintainability from API changes
    - test cases are structured with folder-by-feature