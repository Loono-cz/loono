import 'package:flutter/cupertino.dart';
import 'package:loono/core/result.dart';
import 'package:loono/dtos/example_api/breeds.dart';
import 'package:loono/services/example.service.dart';

class ExampleNotifier extends ChangeNotifier {
  ExampleNotifier(this._exampleService, {this.breed}) {
    fetchImage();
  }

  final ExampleService _exampleService;
  final Breed? breed;

  // Use a similar style to wrap anything that might not be available straight
  // away, do create a class if you need to fetch multiple values
  Result<String> _result = const Result();

  Result<String> get result => _result;

  Future<void> fetchImage() async {
    if (_result.isLoading) {
      return;
    }

    _result = const Result.loading();
    notifyListeners();

    final response = await _exampleService.getRandomImage(
      breed: breed,
    );

    if (response.hasFailure) {
      _result = const Result.error();
      notifyListeners();
      return;
    }

    _result = Result.success(data: response.value);
    notifyListeners();
  }
}
