import 'package:loono/helpers/healthcare_provider_type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart' show SimpleHealthcareProvider;
import 'package:moor/moor.dart';

part 'healthcare_provider.g.dart';

class HealthcareProviders extends Table {
  @override
  Set<Column> get primaryKey => {locationId, institutionId};

  IntColumn get locationId => integer()();

  IntColumn get institutionId => integer()();

  /// Provides a date of the this healthcare providers update.
  ///
  /// format: YYYY-MM-DD
  TextColumn get updateDate => text().nullable()();

  TextColumn get title => text().nullable()();

  TextColumn get category => text().map(const CategoryConverter()).nullable()();

  TextColumn get street => text().nullable()();

  TextColumn get specialization => text().nullable()();

  TextColumn get houseNumber => text().nullable()();

  TextColumn get city => text().nullable()();

  TextColumn get postalCode => text().nullable()();

  RealColumn get lat => real()();

  RealColumn get lng => real()();
}

@UseDao(tables: [HealthcareProviders])
class HealthcareProvidersDao extends DatabaseAccessor<AppDatabase>
    with _$HealthcareProvidersDaoMixin {
  HealthcareProvidersDao(AppDatabase db) : super(db);

  Stream<List<HealthcareProvider>> watchAll() => select(healthcareProviders).watch();

  /// Updates [HealthcareProviders] with new [SimpleHealthcareProvider] data.
  Future<void> updateAllData(List<SimpleHealthcareProvider> newData, String updateDate) async {
    await delete(healthcareProviders).go();
    await batch(
      (b) {
        b.insertAllOnConflictUpdate(
          healthcareProviders,
          newData
              .map(
                (simpleHealthcareProvider) => HealthcareProvidersCompanion.insert(
                  institutionId: simpleHealthcareProvider.institutionId!,
                  locationId: simpleHealthcareProvider.locationId!,
                  title: Value(simpleHealthcareProvider.title),
                  street: Value(simpleHealthcareProvider.street),
                  houseNumber: Value(simpleHealthcareProvider.houseNumber),
                  city: Value(simpleHealthcareProvider.city),
                  postalCode: Value(simpleHealthcareProvider.postalCode),
                  lat: double.parse(simpleHealthcareProvider.lat!),
                  lng: double.parse(simpleHealthcareProvider.lng!),
                  category: Value(simpleHealthcareProvider.category),
                  specialization: Value(simpleHealthcareProvider.specialization),
                  updateDate: Value(updateDate),
                ),
              )
              .toList(),
        );
      },
    );
  }

  // TODO: Add more search queries
  Stream<List<HealthcareProvider>> searchByCity(String query) =>
      (select(healthcareProviders)..where((tbl) => tbl.city.like('%$query%'))).watch();
}
