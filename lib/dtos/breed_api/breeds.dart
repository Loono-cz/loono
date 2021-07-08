enum Breed {
  germanShepherd,
  husky,
}

extension BreedExt on Breed {
  String get asString {
    return toString().split('.').last.toLowerCase();
  }

  String get prettyString {
    if (this == Breed.germanShepherd) {
      return 'German Shepherd';
    }

    if (this == Breed.husky) {
      return 'Husky';
    }

    throw UnimplementedError('Missing pretty String for $this');
  }
}
