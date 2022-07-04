part of '../test_cases/tc_doctor_postal_codes.dart';

final _mikulovice1 = createSimpleHealthcareProviderObject(
  locationId: 1,
  institutionId: 1000,
  title: 'doktor1',
  city: 'Mikulovice',
  postalCode: '67133',
  street: 'ulice1',
  category: ['Praktický lékař'],
  specialization: 'všeobecné praktické lékařství',
  lat: 48.955306580049,
  lng: 16.093059698526,
);

final _mikulovice2Close = createSimpleHealthcareProviderObject(
  locationId: 2,
  institutionId: 2000,
  title: 'doktor2',
  city: 'Mikulovice',
  postalCode: '67134',
  street: 'ulice2',
  category: ['Praktický lékař'],
  specialization: 'všeobecné praktické lékařství',
  lat: 48.955306580000,
  lng: 16.093059698526,
);

final _mikulovice3VeryFar = createSimpleHealthcareProviderObject(
  locationId: 3,
  institutionId: 3000,
  title: 'doktor3',
  city: 'Mikulovice',
  postalCode: '79084',
  street: 'ulice3',
  category: ['Praktický lékař'],
  specialization: 'všeobecné praktické lékařství',
  lat: 50.299135942621,
  lng: 17.319501852798,
);