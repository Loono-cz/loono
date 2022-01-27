import 'package:built_collection/built_collection.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart' show SimpleHealthcareProvider;
import 'package:moor/moor.dart';

part 'healthcare_provider.g.dart';

class HealthcareProviders extends Table {
  @override
  Set<Column> get primaryKey => {locationId, institutionId};

  IntColumn get locationId => integer()();

  IntColumn get institutionId => integer()();

  TextColumn get title => text()();

  TextColumn get category => text().map(const CategoryDbConverter())();

  TextColumn get street => text()();

  TextColumn get houseNumber => text()();

  TextColumn get specialization => text().nullable()();

  TextColumn get city => text()();

  TextColumn get postalCode => text()();

  RealColumn get lat => real()();

  RealColumn get lng => real()();
}

@UseDao(tables: [HealthcareProviders])
class HealthcareProvidersDao extends DatabaseAccessor<AppDatabase>
    with _$HealthcareProvidersDaoMixin {
  HealthcareProvidersDao(AppDatabase db) : super(db);

  Future<List<HealthcareProvider>> getAll() => select(healthcareProviders).get();

  Future<void> updateAllData(BuiltList<SimpleHealthcareProvider> newData) async {
    await delete(healthcareProviders).go();
    await batch(
      (b) {
        b.insertAllOnConflictUpdate(
          healthcareProviders,
          newData
              .map(
                (simpleHealthcareProvider) => HealthcareProvidersCompanion.insert(
                  institutionId: simpleHealthcareProvider.institutionId,
                  locationId: simpleHealthcareProvider.locationId,
                  title: simpleHealthcareProvider.title,
                  street: simpleHealthcareProvider.street ?? '',
                  houseNumber: simpleHealthcareProvider.houseNumber,
                  city: simpleHealthcareProvider.city,
                  postalCode: simpleHealthcareProvider.postalCode,
                  lat: simpleHealthcareProvider.lat,
                  lng: simpleHealthcareProvider.lng,
                  category: simpleHealthcareProvider.category,
                  specialization: Value(simpleHealthcareProvider.specialization),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
