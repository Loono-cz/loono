import 'package:flutter/material.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/find_doctor/map_preview.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class FindDoctorScreen extends StatelessWidget {
  FindDoctorScreen({Key? key}) : super(key: key);

  final _healthcareProviderRepository = registry.get<HealthcareProviderRepository>();

  final _healthcareProvidersDao = registry.get<DatabaseService>().healthcareProviders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
          // TODO: Update only if outdated or it is first time fetch
          future: _healthcareProviderRepository.updateAllData(_fakeData, '2021-11-02'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<List<HealthcareProvider>>(
                stream: _healthcareProvidersDao.searchByCity('City1'),
                builder: (context, snapshot) {
                  debugPrint(snapshot.data.toString());
                  return const MapPreview();
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

final _fakeData = <SimpleHealthcareProvider>[
  ...List.generate(
    11,
    (index) => (SimpleHealthcareProvider().toBuilder()
          ..city = 'City$index'
          ..lng = '2121212'
          ..lat = '12211212.21242'
          ..institutionId = index
          ..locationId = index)
        .build(),
  ),
];
