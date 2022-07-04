import 'package:built_collection/built_collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../test_helpers/dart_objects_gens.dart';

const LatLng olomoucLatLng = LatLng(49.589044036846, 17.244470939568);

final generalPractitionerInSumperk = createSimpleHealthcareProviderObject(
  locationId: 1,
  institutionId: 1000,
  title: 'MUDr. Vilhelm Hlavatý',
  city: 'Šumperk',
  postalCode: '78701',
  street: 'Nerušná',
  category: ['Praktický lékař'],
  specialization: 'všeobecné praktické lékařství',
  lat: 49.96039600582,
  lng: 16.978607408738,
);

final dermatologistInSumperk2ndFloor = generalPractitionerInSumperk.rebuild(
  (b) => b
    ..institutionId = 1002
    ..title = 'MUDr. Jan DruhýPatro'
    ..category = ['Dermatovenorologie, kožní'].toBuiltList().toBuilder()
    ..specialization = 'dermatovenorologie',
);

final dentistInPrague = createSimpleHealthcareProviderObject(
  locationId: 2,
  institutionId: 2000,
  title: 'MUDr. Aneta Tatiana',
  city: 'Praha 18',
  postalCode: '19900',
  street: 'Rušná',
  category: ['Zubař'],
  specialization: 'zubní lékařství',
  lat: 50.136572599675,
  lng: 14.510125209968,
);
