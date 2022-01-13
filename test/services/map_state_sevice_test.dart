import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/map_state_sevice.dart';

HealthcareProvider createHealthcareProvider({
  String? title,
}) {
  return HealthcareProvider(
    locationId: 0,
    institutionId: 0,
    title: title ?? '',
    category: BuiltList.from(<String>[]),
    street: '',
    houseNumber: '',
    city: '',
    postalCode: '',
    lat: 0,
    lng: 0,
  );
}

void main() {
  late MapStateService mapStateService;

  group('query search', () {
    final List<HealthcareProvider> doctors = <String>[
      'Revmatologie Mariánské Lázně s.r.o.',
      'MUDr. Milena Nováková',
      'Bc. Jiří Novák',
    ].map((e) => createHealthcareProvider(title: e)).toList();

    setUp(() {
      mapStateService = MapStateService();
    });

    test('finds by query which has no diacritics', () {
      // Arrange
      const query = 'novak';

      // Act
      mapStateService.addAll(doctors);
      final results = mapStateService.searchByTitle(query);

      // Assert
      expect(
        results.map((e) => e.title).toList(),
        unorderedEquals(<String>['MUDr. Milena Nováková', 'Bc. Jiří Novák']),
      );
    });

    test('finds by query which has diacritics', () {
      // Arrange
      const query = 'novák';

      // Act
      mapStateService.addAll(doctors);
      final results = mapStateService.searchByTitle(query);

      // Assert
      expect(
        results.map((e) => e.title).toList(),
        unorderedEquals(<String>['MUDr. Milena Nováková', 'Bc. Jiří Novák']),
      );
    });

    test('finds all with empty query', () {
      // Arrange
      const query = '';

      // Act
      mapStateService.addAll(doctors);
      final results = mapStateService.searchByTitle(query);

      // Assert
      expect(results, unorderedEquals(doctors));
    });
  });
}
