
enum Breed {
  germanShepherd,
  husky,
}

extension BreedExt on Breed {
  String get asString {
    return toString().split('.').last.toLowerCase();
  }
}