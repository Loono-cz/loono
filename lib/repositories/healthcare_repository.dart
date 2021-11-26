import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';

class HealthcareProviderRepository {
  HealthcareProviderRepository({
    required DatabaseService databaseService,
  }) : _db = databaseService;

  final DatabaseService _db;

  Future<void> updateAllData(List<SimpleHealthcareProvider> newData, String updateDate) async {
    await _db.healthcareProviders.updateAllData(newData, updateDate);
  }

  Stream<List<HealthcareProvider>> searchByCity(String query) {
    return _db.healthcareProviders.searchByCity(query);
  }
}
