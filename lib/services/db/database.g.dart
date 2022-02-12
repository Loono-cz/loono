// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String id;
  final Sex? sex;
  final String? dateOfBirthRaw;
  final String? nickname;
  final String? email;
  final String? profileImageUrl;
  final String? defaultDeviceCalendarId;
  final DateTime? latestMapUpdateCheck;
  final DateTime? latestMapUpdate;
  User(
      {required this.id,
      this.sex,
      this.dateOfBirthRaw,
      this.nickname,
      this.email,
      this.profileImageUrl,
      this.defaultDeviceCalendarId,
      this.latestMapUpdateCheck,
      this.latestMapUpdate});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sex: $UsersTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sex'])),
      dateOfBirthRaw: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_of_birth_raw']),
      nickname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nickname']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      profileImageUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_image_url']),
      defaultDeviceCalendarId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}default_device_calendar_id']),
      latestMapUpdateCheck: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}latest_map_update_check']),
      latestMapUpdate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latest_map_update']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sex != null) {
      final converter = $UsersTable.$converter0;
      map['sex'] = Variable<String?>(converter.mapToSql(sex));
    }
    if (!nullToAbsent || dateOfBirthRaw != null) {
      map['date_of_birth_raw'] = Variable<String?>(dateOfBirthRaw);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String?>(nickname);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || profileImageUrl != null) {
      map['profile_image_url'] = Variable<String?>(profileImageUrl);
    }
    if (!nullToAbsent || defaultDeviceCalendarId != null) {
      map['default_device_calendar_id'] =
          Variable<String?>(defaultDeviceCalendarId);
    }
    if (!nullToAbsent || latestMapUpdateCheck != null) {
      map['latest_map_update_check'] =
          Variable<DateTime?>(latestMapUpdateCheck);
    }
    if (!nullToAbsent || latestMapUpdate != null) {
      map['latest_map_update'] = Variable<DateTime?>(latestMapUpdate);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      dateOfBirthRaw: dateOfBirthRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirthRaw),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      profileImageUrl: profileImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImageUrl),
      defaultDeviceCalendarId: defaultDeviceCalendarId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDeviceCalendarId),
      latestMapUpdateCheck: latestMapUpdateCheck == null && nullToAbsent
          ? const Value.absent()
          : Value(latestMapUpdateCheck),
      latestMapUpdate: latestMapUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(latestMapUpdate),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      sex: serializer.fromJson<Sex?>(json['sex']),
      dateOfBirthRaw: serializer.fromJson<String?>(json['dateOfBirthRaw']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      email: serializer.fromJson<String?>(json['email']),
      profileImageUrl: serializer.fromJson<String?>(json['profileImageUrl']),
      defaultDeviceCalendarId:
          serializer.fromJson<String?>(json['defaultDeviceCalendarId']),
      latestMapUpdateCheck:
          serializer.fromJson<DateTime?>(json['latestMapUpdateCheck']),
      latestMapUpdate: serializer.fromJson<DateTime?>(json['latestMapUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sex': serializer.toJson<Sex?>(sex),
      'dateOfBirthRaw': serializer.toJson<String?>(dateOfBirthRaw),
      'nickname': serializer.toJson<String?>(nickname),
      'email': serializer.toJson<String?>(email),
      'profileImageUrl': serializer.toJson<String?>(profileImageUrl),
      'defaultDeviceCalendarId':
          serializer.toJson<String?>(defaultDeviceCalendarId),
      'latestMapUpdateCheck':
          serializer.toJson<DateTime?>(latestMapUpdateCheck),
      'latestMapUpdate': serializer.toJson<DateTime?>(latestMapUpdate),
    };
  }

  User copyWith(
          {String? id,
          Sex? sex,
          String? dateOfBirthRaw,
          String? nickname,
          String? email,
          String? profileImageUrl,
          String? defaultDeviceCalendarId,
          DateTime? latestMapUpdateCheck,
          DateTime? latestMapUpdate}) =>
      User(
        id: id ?? this.id,
        sex: sex ?? this.sex,
        dateOfBirthRaw: dateOfBirthRaw ?? this.dateOfBirthRaw,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        defaultDeviceCalendarId:
            defaultDeviceCalendarId ?? this.defaultDeviceCalendarId,
        latestMapUpdateCheck: latestMapUpdateCheck ?? this.latestMapUpdateCheck,
        latestMapUpdate: latestMapUpdate ?? this.latestMapUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('dateOfBirthRaw: $dateOfBirthRaw, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('defaultDeviceCalendarId: $defaultDeviceCalendarId, ')
          ..write('latestMapUpdateCheck: $latestMapUpdateCheck, ')
          ..write('latestMapUpdate: $latestMapUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          sex.hashCode,
          $mrjc(
              dateOfBirthRaw.hashCode,
              $mrjc(
                  nickname.hashCode,
                  $mrjc(
                      email.hashCode,
                      $mrjc(
                          profileImageUrl.hashCode,
                          $mrjc(
                              defaultDeviceCalendarId.hashCode,
                              $mrjc(latestMapUpdateCheck.hashCode,
                                  latestMapUpdate.hashCode)))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.dateOfBirthRaw == this.dateOfBirthRaw &&
          other.nickname == this.nickname &&
          other.email == this.email &&
          other.profileImageUrl == this.profileImageUrl &&
          other.defaultDeviceCalendarId == this.defaultDeviceCalendarId &&
          other.latestMapUpdateCheck == this.latestMapUpdateCheck &&
          other.latestMapUpdate == this.latestMapUpdate);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<Sex?> sex;
  final Value<String?> dateOfBirthRaw;
  final Value<String?> nickname;
  final Value<String?> email;
  final Value<String?> profileImageUrl;
  final Value<String?> defaultDeviceCalendarId;
  final Value<DateTime?> latestMapUpdateCheck;
  final Value<DateTime?> latestMapUpdate;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.dateOfBirthRaw = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.defaultDeviceCalendarId = const Value.absent(),
    this.latestMapUpdateCheck = const Value.absent(),
    this.latestMapUpdate = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.sex = const Value.absent(),
    this.dateOfBirthRaw = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.defaultDeviceCalendarId = const Value.absent(),
    this.latestMapUpdateCheck = const Value.absent(),
    this.latestMapUpdate = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<Sex?>? sex,
    Expression<String?>? dateOfBirthRaw,
    Expression<String?>? nickname,
    Expression<String?>? email,
    Expression<String?>? profileImageUrl,
    Expression<String?>? defaultDeviceCalendarId,
    Expression<DateTime?>? latestMapUpdateCheck,
    Expression<DateTime?>? latestMapUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (dateOfBirthRaw != null) 'date_of_birth_raw': dateOfBirthRaw,
      if (nickname != null) 'nickname': nickname,
      if (email != null) 'email': email,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      if (defaultDeviceCalendarId != null)
        'default_device_calendar_id': defaultDeviceCalendarId,
      if (latestMapUpdateCheck != null)
        'latest_map_update_check': latestMapUpdateCheck,
      if (latestMapUpdate != null) 'latest_map_update': latestMapUpdate,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<Sex?>? sex,
      Value<String?>? dateOfBirthRaw,
      Value<String?>? nickname,
      Value<String?>? email,
      Value<String?>? profileImageUrl,
      Value<String?>? defaultDeviceCalendarId,
      Value<DateTime?>? latestMapUpdateCheck,
      Value<DateTime?>? latestMapUpdate}) {
    return UsersCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      dateOfBirthRaw: dateOfBirthRaw ?? this.dateOfBirthRaw,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      defaultDeviceCalendarId:
          defaultDeviceCalendarId ?? this.defaultDeviceCalendarId,
      latestMapUpdateCheck: latestMapUpdateCheck ?? this.latestMapUpdateCheck,
      latestMapUpdate: latestMapUpdate ?? this.latestMapUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sex.present) {
      final converter = $UsersTable.$converter0;
      map['sex'] = Variable<String?>(converter.mapToSql(sex.value));
    }
    if (dateOfBirthRaw.present) {
      map['date_of_birth_raw'] = Variable<String?>(dateOfBirthRaw.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String?>(nickname.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (profileImageUrl.present) {
      map['profile_image_url'] = Variable<String?>(profileImageUrl.value);
    }
    if (defaultDeviceCalendarId.present) {
      map['default_device_calendar_id'] =
          Variable<String?>(defaultDeviceCalendarId.value);
    }
    if (latestMapUpdateCheck.present) {
      map['latest_map_update_check'] =
          Variable<DateTime?>(latestMapUpdateCheck.value);
    }
    if (latestMapUpdate.present) {
      map['latest_map_update'] = Variable<DateTime?>(latestMapUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('dateOfBirthRaw: $dateOfBirthRaw, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('defaultDeviceCalendarId: $defaultDeviceCalendarId, ')
          ..write('latestMapUpdateCheck: $latestMapUpdateCheck, ')
          ..write('latestMapUpdate: $latestMapUpdate')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumnWithTypeConverter<Sex, String?> sex =
      GeneratedColumn<String?>('sex', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<Sex>($UsersTable.$converter0);
  final VerificationMeta _dateOfBirthRawMeta =
      const VerificationMeta('dateOfBirthRaw');
  late final GeneratedColumn<String?> dateOfBirthRaw = GeneratedColumn<String?>(
      'date_of_birth_raw', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  late final GeneratedColumn<String?> nickname = GeneratedColumn<String?>(
      'nickname', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _profileImageUrlMeta =
      const VerificationMeta('profileImageUrl');
  late final GeneratedColumn<String?> profileImageUrl =
      GeneratedColumn<String?>('profile_image_url', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _defaultDeviceCalendarIdMeta =
      const VerificationMeta('defaultDeviceCalendarId');
  late final GeneratedColumn<String?> defaultDeviceCalendarId =
      GeneratedColumn<String?>('default_device_calendar_id', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _latestMapUpdateCheckMeta =
      const VerificationMeta('latestMapUpdateCheck');
  late final GeneratedColumn<DateTime?> latestMapUpdateCheck =
      GeneratedColumn<DateTime?>('latest_map_update_check', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _latestMapUpdateMeta =
      const VerificationMeta('latestMapUpdate');
  late final GeneratedColumn<DateTime?> latestMapUpdate =
      GeneratedColumn<DateTime?>('latest_map_update', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sex,
        dateOfBirthRaw,
        nickname,
        email,
        profileImageUrl,
        defaultDeviceCalendarId,
        latestMapUpdateCheck,
        latestMapUpdate
      ];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_sexMeta, const VerificationResult.success());
    if (data.containsKey('date_of_birth_raw')) {
      context.handle(
          _dateOfBirthRawMeta,
          dateOfBirthRaw.isAcceptableOrUnknown(
              data['date_of_birth_raw']!, _dateOfBirthRawMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('profile_image_url')) {
      context.handle(
          _profileImageUrlMeta,
          profileImageUrl.isAcceptableOrUnknown(
              data['profile_image_url']!, _profileImageUrlMeta));
    }
    if (data.containsKey('default_device_calendar_id')) {
      context.handle(
          _defaultDeviceCalendarIdMeta,
          defaultDeviceCalendarId.isAcceptableOrUnknown(
              data['default_device_calendar_id']!,
              _defaultDeviceCalendarIdMeta));
    }
    if (data.containsKey('latest_map_update_check')) {
      context.handle(
          _latestMapUpdateCheckMeta,
          latestMapUpdateCheck.isAcceptableOrUnknown(
              data['latest_map_update_check']!, _latestMapUpdateCheckMeta));
    }
    if (data.containsKey('latest_map_update')) {
      context.handle(
          _latestMapUpdateMeta,
          latestMapUpdate.isAcceptableOrUnknown(
              data['latest_map_update']!, _latestMapUpdateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }

  static TypeConverter<Sex, String> $converter0 = const SexDbConverter();
}

class HealthcareProvider extends DataClass
    implements Insertable<HealthcareProvider> {
  final int locationId;
  final int institutionId;
  final String title;
  final BuiltList<String> category;
  final String street;
  final String houseNumber;
  final String? specialization;
  final String city;
  final String postalCode;
  final double lat;
  final double lng;
  HealthcareProvider(
      {required this.locationId,
      required this.institutionId,
      required this.title,
      required this.category,
      required this.street,
      required this.houseNumber,
      this.specialization,
      required this.city,
      required this.postalCode,
      required this.lat,
      required this.lng});
  factory HealthcareProvider.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return HealthcareProvider(
      locationId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location_id'])!,
      institutionId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}institution_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      category: $HealthcareProvidersTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}category']))!,
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street'])!,
      houseNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}house_number'])!,
      specialization: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specialization']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city'])!,
      postalCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}postal_code'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['location_id'] = Variable<int>(locationId);
    map['institution_id'] = Variable<int>(institutionId);
    map['title'] = Variable<String>(title);
    {
      final converter = $HealthcareProvidersTable.$converter0;
      map['category'] = Variable<String>(converter.mapToSql(category)!);
    }
    map['street'] = Variable<String>(street);
    map['house_number'] = Variable<String>(houseNumber);
    if (!nullToAbsent || specialization != null) {
      map['specialization'] = Variable<String?>(specialization);
    }
    map['city'] = Variable<String>(city);
    map['postal_code'] = Variable<String>(postalCode);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  HealthcareProvidersCompanion toCompanion(bool nullToAbsent) {
    return HealthcareProvidersCompanion(
      locationId: Value(locationId),
      institutionId: Value(institutionId),
      title: Value(title),
      category: Value(category),
      street: Value(street),
      houseNumber: Value(houseNumber),
      specialization: specialization == null && nullToAbsent
          ? const Value.absent()
          : Value(specialization),
      city: Value(city),
      postalCode: Value(postalCode),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory HealthcareProvider.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HealthcareProvider(
      locationId: serializer.fromJson<int>(json['locationId']),
      institutionId: serializer.fromJson<int>(json['institutionId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<BuiltList<String>>(json['category']),
      street: serializer.fromJson<String>(json['street']),
      houseNumber: serializer.fromJson<String>(json['houseNumber']),
      specialization: serializer.fromJson<String?>(json['specialization']),
      city: serializer.fromJson<String>(json['city']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'locationId': serializer.toJson<int>(locationId),
      'institutionId': serializer.toJson<int>(institutionId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<BuiltList<String>>(category),
      'street': serializer.toJson<String>(street),
      'houseNumber': serializer.toJson<String>(houseNumber),
      'specialization': serializer.toJson<String?>(specialization),
      'city': serializer.toJson<String>(city),
      'postalCode': serializer.toJson<String>(postalCode),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  HealthcareProvider copyWith(
          {int? locationId,
          int? institutionId,
          String? title,
          BuiltList<String>? category,
          String? street,
          String? houseNumber,
          String? specialization,
          String? city,
          String? postalCode,
          double? lat,
          double? lng}) =>
      HealthcareProvider(
        locationId: locationId ?? this.locationId,
        institutionId: institutionId ?? this.institutionId,
        title: title ?? this.title,
        category: category ?? this.category,
        street: street ?? this.street,
        houseNumber: houseNumber ?? this.houseNumber,
        specialization: specialization ?? this.specialization,
        city: city ?? this.city,
        postalCode: postalCode ?? this.postalCode,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  @override
  String toString() {
    return (StringBuffer('HealthcareProvider(')
          ..write('locationId: $locationId, ')
          ..write('institutionId: $institutionId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('street: $street, ')
          ..write('houseNumber: $houseNumber, ')
          ..write('specialization: $specialization, ')
          ..write('city: $city, ')
          ..write('postalCode: $postalCode, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      locationId.hashCode,
      $mrjc(
          institutionId.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(
                  category.hashCode,
                  $mrjc(
                      street.hashCode,
                      $mrjc(
                          houseNumber.hashCode,
                          $mrjc(
                              specialization.hashCode,
                              $mrjc(
                                  city.hashCode,
                                  $mrjc(
                                      postalCode.hashCode,
                                      $mrjc(
                                          lat.hashCode, lng.hashCode)))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthcareProvider &&
          other.locationId == this.locationId &&
          other.institutionId == this.institutionId &&
          other.title == this.title &&
          other.category == this.category &&
          other.street == this.street &&
          other.houseNumber == this.houseNumber &&
          other.specialization == this.specialization &&
          other.city == this.city &&
          other.postalCode == this.postalCode &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class HealthcareProvidersCompanion extends UpdateCompanion<HealthcareProvider> {
  final Value<int> locationId;
  final Value<int> institutionId;
  final Value<String> title;
  final Value<BuiltList<String>> category;
  final Value<String> street;
  final Value<String> houseNumber;
  final Value<String?> specialization;
  final Value<String> city;
  final Value<String> postalCode;
  final Value<double> lat;
  final Value<double> lng;
  const HealthcareProvidersCompanion({
    this.locationId = const Value.absent(),
    this.institutionId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.street = const Value.absent(),
    this.houseNumber = const Value.absent(),
    this.specialization = const Value.absent(),
    this.city = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  HealthcareProvidersCompanion.insert({
    required int locationId,
    required int institutionId,
    required String title,
    required BuiltList<String> category,
    required String street,
    required String houseNumber,
    this.specialization = const Value.absent(),
    required String city,
    required String postalCode,
    required double lat,
    required double lng,
  })  : locationId = Value(locationId),
        institutionId = Value(institutionId),
        title = Value(title),
        category = Value(category),
        street = Value(street),
        houseNumber = Value(houseNumber),
        city = Value(city),
        postalCode = Value(postalCode),
        lat = Value(lat),
        lng = Value(lng);
  static Insertable<HealthcareProvider> custom({
    Expression<int>? locationId,
    Expression<int>? institutionId,
    Expression<String>? title,
    Expression<BuiltList<String>>? category,
    Expression<String>? street,
    Expression<String>? houseNumber,
    Expression<String?>? specialization,
    Expression<String>? city,
    Expression<String>? postalCode,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (locationId != null) 'location_id': locationId,
      if (institutionId != null) 'institution_id': institutionId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (street != null) 'street': street,
      if (houseNumber != null) 'house_number': houseNumber,
      if (specialization != null) 'specialization': specialization,
      if (city != null) 'city': city,
      if (postalCode != null) 'postal_code': postalCode,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  HealthcareProvidersCompanion copyWith(
      {Value<int>? locationId,
      Value<int>? institutionId,
      Value<String>? title,
      Value<BuiltList<String>>? category,
      Value<String>? street,
      Value<String>? houseNumber,
      Value<String?>? specialization,
      Value<String>? city,
      Value<String>? postalCode,
      Value<double>? lat,
      Value<double>? lng}) {
    return HealthcareProvidersCompanion(
      locationId: locationId ?? this.locationId,
      institutionId: institutionId ?? this.institutionId,
      title: title ?? this.title,
      category: category ?? this.category,
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
      specialization: specialization ?? this.specialization,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (locationId.present) {
      map['location_id'] = Variable<int>(locationId.value);
    }
    if (institutionId.present) {
      map['institution_id'] = Variable<int>(institutionId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      final converter = $HealthcareProvidersTable.$converter0;
      map['category'] = Variable<String>(converter.mapToSql(category.value)!);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (houseNumber.present) {
      map['house_number'] = Variable<String>(houseNumber.value);
    }
    if (specialization.present) {
      map['specialization'] = Variable<String?>(specialization.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthcareProvidersCompanion(')
          ..write('locationId: $locationId, ')
          ..write('institutionId: $institutionId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('street: $street, ')
          ..write('houseNumber: $houseNumber, ')
          ..write('specialization: $specialization, ')
          ..write('city: $city, ')
          ..write('postalCode: $postalCode, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $HealthcareProvidersTable extends HealthcareProviders
    with TableInfo<$HealthcareProvidersTable, HealthcareProvider> {
  final GeneratedDatabase _db;
  final String? _alias;
  $HealthcareProvidersTable(this._db, [this._alias]);
  final VerificationMeta _locationIdMeta = const VerificationMeta('locationId');
  late final GeneratedColumn<int?> locationId = GeneratedColumn<int?>(
      'location_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _institutionIdMeta =
      const VerificationMeta('institutionId');
  late final GeneratedColumn<int?> institutionId = GeneratedColumn<int?>(
      'institution_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumnWithTypeConverter<BuiltList<String>, String?>
      category = GeneratedColumn<String?>('category', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<BuiltList<String>>(
              $HealthcareProvidersTable.$converter0);
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _houseNumberMeta =
      const VerificationMeta('houseNumber');
  late final GeneratedColumn<String?> houseNumber = GeneratedColumn<String?>(
      'house_number', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _specializationMeta =
      const VerificationMeta('specialization');
  late final GeneratedColumn<String?> specialization = GeneratedColumn<String?>(
      'specialization', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _postalCodeMeta = const VerificationMeta('postalCode');
  late final GeneratedColumn<String?> postalCode = GeneratedColumn<String?>(
      'postal_code', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  late final GeneratedColumn<double?> lng = GeneratedColumn<double?>(
      'lng', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        locationId,
        institutionId,
        title,
        category,
        street,
        houseNumber,
        specialization,
        city,
        postalCode,
        lat,
        lng
      ];
  @override
  String get aliasedName => _alias ?? 'healthcare_providers';
  @override
  String get actualTableName => 'healthcare_providers';
  @override
  VerificationContext validateIntegrity(Insertable<HealthcareProvider> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('institution_id')) {
      context.handle(
          _institutionIdMeta,
          institutionId.isAcceptableOrUnknown(
              data['institution_id']!, _institutionIdMeta));
    } else if (isInserting) {
      context.missing(_institutionIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_categoryMeta, const VerificationResult.success());
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('house_number')) {
      context.handle(
          _houseNumberMeta,
          houseNumber.isAcceptableOrUnknown(
              data['house_number']!, _houseNumberMeta));
    } else if (isInserting) {
      context.missing(_houseNumberMeta);
    }
    if (data.containsKey('specialization')) {
      context.handle(
          _specializationMeta,
          specialization.isAcceptableOrUnknown(
              data['specialization']!, _specializationMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {locationId, institutionId};
  @override
  HealthcareProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    return HealthcareProvider.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HealthcareProvidersTable createAlias(String alias) {
    return $HealthcareProvidersTable(_db, alias);
  }

  static TypeConverter<BuiltList<String>, String> $converter0 =
      const CategoryDbConverter();
}

class CalendarEvent extends DataClass implements Insertable<CalendarEvent> {
  final ExaminationTypeEnum type;
  final String deviceCalendarId;
  final String calendarEventId;
  final DateTime date;
  CalendarEvent(
      {required this.type,
      required this.deviceCalendarId,
      required this.calendarEventId,
      required this.date});
  factory CalendarEvent.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CalendarEvent(
      type: $CalendarEventsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      deviceCalendarId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}device_calendar_id'])!,
      calendarEventId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}calendar_event_id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $CalendarEventsTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type)!);
    }
    map['device_calendar_id'] = Variable<String>(deviceCalendarId);
    map['calendar_event_id'] = Variable<String>(calendarEventId);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  CalendarEventsCompanion toCompanion(bool nullToAbsent) {
    return CalendarEventsCompanion(
      type: Value(type),
      deviceCalendarId: Value(deviceCalendarId),
      calendarEventId: Value(calendarEventId),
      date: Value(date),
    );
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CalendarEvent(
      type: serializer.fromJson<ExaminationTypeEnum>(json['type']),
      deviceCalendarId: serializer.fromJson<String>(json['deviceCalendarId']),
      calendarEventId: serializer.fromJson<String>(json['calendarEventId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<ExaminationTypeEnum>(type),
      'deviceCalendarId': serializer.toJson<String>(deviceCalendarId),
      'calendarEventId': serializer.toJson<String>(calendarEventId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  CalendarEvent copyWith(
          {ExaminationTypeEnum? type,
          String? deviceCalendarId,
          String? calendarEventId,
          DateTime? date}) =>
      CalendarEvent(
        type: type ?? this.type,
        deviceCalendarId: deviceCalendarId ?? this.deviceCalendarId,
        calendarEventId: calendarEventId ?? this.calendarEventId,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('CalendarEvent(')
          ..write('type: $type, ')
          ..write('deviceCalendarId: $deviceCalendarId, ')
          ..write('calendarEventId: $calendarEventId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      type.hashCode,
      $mrjc(deviceCalendarId.hashCode,
          $mrjc(calendarEventId.hashCode, date.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarEvent &&
          other.type == this.type &&
          other.deviceCalendarId == this.deviceCalendarId &&
          other.calendarEventId == this.calendarEventId &&
          other.date == this.date);
}

class CalendarEventsCompanion extends UpdateCompanion<CalendarEvent> {
  final Value<ExaminationTypeEnum> type;
  final Value<String> deviceCalendarId;
  final Value<String> calendarEventId;
  final Value<DateTime> date;
  const CalendarEventsCompanion({
    this.type = const Value.absent(),
    this.deviceCalendarId = const Value.absent(),
    this.calendarEventId = const Value.absent(),
    this.date = const Value.absent(),
  });
  CalendarEventsCompanion.insert({
    required ExaminationTypeEnum type,
    required String deviceCalendarId,
    required String calendarEventId,
    required DateTime date,
  })  : type = Value(type),
        deviceCalendarId = Value(deviceCalendarId),
        calendarEventId = Value(calendarEventId),
        date = Value(date);
  static Insertable<CalendarEvent> custom({
    Expression<ExaminationTypeEnum>? type,
    Expression<String>? deviceCalendarId,
    Expression<String>? calendarEventId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (deviceCalendarId != null) 'device_calendar_id': deviceCalendarId,
      if (calendarEventId != null) 'calendar_event_id': calendarEventId,
      if (date != null) 'date': date,
    });
  }

  CalendarEventsCompanion copyWith(
      {Value<ExaminationTypeEnum>? type,
      Value<String>? deviceCalendarId,
      Value<String>? calendarEventId,
      Value<DateTime>? date}) {
    return CalendarEventsCompanion(
      type: type ?? this.type,
      deviceCalendarId: deviceCalendarId ?? this.deviceCalendarId,
      calendarEventId: calendarEventId ?? this.calendarEventId,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      final converter = $CalendarEventsTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type.value)!);
    }
    if (deviceCalendarId.present) {
      map['device_calendar_id'] = Variable<String>(deviceCalendarId.value);
    }
    if (calendarEventId.present) {
      map['calendar_event_id'] = Variable<String>(calendarEventId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEventsCompanion(')
          ..write('type: $type, ')
          ..write('deviceCalendarId: $deviceCalendarId, ')
          ..write('calendarEventId: $calendarEventId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CalendarEventsTable extends CalendarEvents
    with TableInfo<$CalendarEventsTable, CalendarEvent> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CalendarEventsTable(this._db, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<ExaminationTypeEnum, String?>
      type = GeneratedColumn<String?>('type', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<ExaminationTypeEnum>($CalendarEventsTable.$converter0);
  final VerificationMeta _deviceCalendarIdMeta =
      const VerificationMeta('deviceCalendarId');
  late final GeneratedColumn<String?> deviceCalendarId =
      GeneratedColumn<String?>('device_calendar_id', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _calendarEventIdMeta =
      const VerificationMeta('calendarEventId');
  late final GeneratedColumn<String?> calendarEventId =
      GeneratedColumn<String?>('calendar_event_id', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [type, deviceCalendarId, calendarEventId, date];
  @override
  String get aliasedName => _alias ?? 'calendar_events';
  @override
  String get actualTableName => 'calendar_events';
  @override
  VerificationContext validateIntegrity(Insertable<CalendarEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('device_calendar_id')) {
      context.handle(
          _deviceCalendarIdMeta,
          deviceCalendarId.isAcceptableOrUnknown(
              data['device_calendar_id']!, _deviceCalendarIdMeta));
    } else if (isInserting) {
      context.missing(_deviceCalendarIdMeta);
    }
    if (data.containsKey('calendar_event_id')) {
      context.handle(
          _calendarEventIdMeta,
          calendarEventId.isAcceptableOrUnknown(
              data['calendar_event_id']!, _calendarEventIdMeta));
    } else if (isInserting) {
      context.missing(_calendarEventIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {type};
  @override
  CalendarEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CalendarEvent.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CalendarEventsTable createAlias(String alias) {
    return $CalendarEventsTable(_db, alias);
  }

  static TypeConverter<ExaminationTypeEnum, String> $converter0 =
      const ExaminationTypeEnumDbConverter();
}

class ExaminationQuestionnaire extends DataClass
    implements Insertable<ExaminationQuestionnaire> {
  final ExaminationTypeEnum type;
  final ExaminationStatus status;
  final DateTime? date;
  final bool? firstExam;
  ExaminationQuestionnaire(
      {required this.type, required this.status, this.date, this.firstExam});
  factory ExaminationQuestionnaire.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ExaminationQuestionnaire(
      type: $ExaminationQuestionnairesTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      status: $ExaminationQuestionnairesTable.$converter1.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}status']))!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      firstExam: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_exam']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $ExaminationQuestionnairesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type)!);
    }
    {
      final converter = $ExaminationQuestionnairesTable.$converter1;
      map['status'] = Variable<String>(converter.mapToSql(status)!);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    if (!nullToAbsent || firstExam != null) {
      map['first_exam'] = Variable<bool?>(firstExam);
    }
    return map;
  }

  ExaminationQuestionnairesCompanion toCompanion(bool nullToAbsent) {
    return ExaminationQuestionnairesCompanion(
      type: Value(type),
      status: Value(status),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      firstExam: firstExam == null && nullToAbsent
          ? const Value.absent()
          : Value(firstExam),
    );
  }

  factory ExaminationQuestionnaire.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ExaminationQuestionnaire(
      type: serializer.fromJson<ExaminationTypeEnum>(json['type']),
      status: serializer.fromJson<ExaminationStatus>(json['status']),
      date: serializer.fromJson<DateTime?>(json['date']),
      firstExam: serializer.fromJson<bool?>(json['firstExam']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<ExaminationTypeEnum>(type),
      'status': serializer.toJson<ExaminationStatus>(status),
      'date': serializer.toJson<DateTime?>(date),
      'firstExam': serializer.toJson<bool?>(firstExam),
    };
  }

  ExaminationQuestionnaire copyWith(
          {ExaminationTypeEnum? type,
          ExaminationStatus? status,
          DateTime? date,
          bool? firstExam}) =>
      ExaminationQuestionnaire(
        type: type ?? this.type,
        status: status ?? this.status,
        date: date ?? this.date,
        firstExam: firstExam ?? this.firstExam,
      );
  @override
  String toString() {
    return (StringBuffer('ExaminationQuestionnaire(')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('date: $date, ')
          ..write('firstExam: $firstExam')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(type.hashCode,
      $mrjc(status.hashCode, $mrjc(date.hashCode, firstExam.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExaminationQuestionnaire &&
          other.type == this.type &&
          other.status == this.status &&
          other.date == this.date &&
          other.firstExam == this.firstExam);
}

class ExaminationQuestionnairesCompanion
    extends UpdateCompanion<ExaminationQuestionnaire> {
  final Value<ExaminationTypeEnum> type;
  final Value<ExaminationStatus> status;
  final Value<DateTime?> date;
  final Value<bool?> firstExam;
  const ExaminationQuestionnairesCompanion({
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.date = const Value.absent(),
    this.firstExam = const Value.absent(),
  });
  ExaminationQuestionnairesCompanion.insert({
    required ExaminationTypeEnum type,
    this.status = const Value.absent(),
    this.date = const Value.absent(),
    this.firstExam = const Value.absent(),
  }) : type = Value(type);
  static Insertable<ExaminationQuestionnaire> custom({
    Expression<ExaminationTypeEnum>? type,
    Expression<ExaminationStatus>? status,
    Expression<DateTime?>? date,
    Expression<bool?>? firstExam,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (date != null) 'date': date,
      if (firstExam != null) 'first_exam': firstExam,
    });
  }

  ExaminationQuestionnairesCompanion copyWith(
      {Value<ExaminationTypeEnum>? type,
      Value<ExaminationStatus>? status,
      Value<DateTime?>? date,
      Value<bool?>? firstExam}) {
    return ExaminationQuestionnairesCompanion(
      type: type ?? this.type,
      status: status ?? this.status,
      date: date ?? this.date,
      firstExam: firstExam ?? this.firstExam,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      final converter = $ExaminationQuestionnairesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type.value)!);
    }
    if (status.present) {
      final converter = $ExaminationQuestionnairesTable.$converter1;
      map['status'] = Variable<String>(converter.mapToSql(status.value)!);
    }
    if (date.present) {
      map['date'] = Variable<DateTime?>(date.value);
    }
    if (firstExam.present) {
      map['first_exam'] = Variable<bool?>(firstExam.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationQuestionnairesCompanion(')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('date: $date, ')
          ..write('firstExam: $firstExam')
          ..write(')'))
        .toString();
  }
}

class $ExaminationQuestionnairesTable extends ExaminationQuestionnaires
    with TableInfo<$ExaminationQuestionnairesTable, ExaminationQuestionnaire> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ExaminationQuestionnairesTable(this._db, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<ExaminationTypeEnum, String?>
      type = GeneratedColumn<String?>('type', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<ExaminationTypeEnum>(
              $ExaminationQuestionnairesTable.$converter0);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumnWithTypeConverter<ExaminationStatus, String?>
      status = GeneratedColumn<String?>('status', aliasedName, false,
              typeName: 'TEXT',
              requiredDuringInsert: false,
              defaultValue: Constant(const ExaminationStatusDbConverter()
                  .mapToSql(ExaminationStatus.NEW)!))
          .withConverter<ExaminationStatus>(
              $ExaminationQuestionnairesTable.$converter1);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _firstExamMeta = const VerificationMeta('firstExam');
  late final GeneratedColumn<bool?> firstExam = GeneratedColumn<bool?>(
      'first_exam', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (first_exam IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [type, status, date, firstExam];
  @override
  String get aliasedName => _alias ?? 'examination_questionnaires';
  @override
  String get actualTableName => 'examination_questionnaires';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExaminationQuestionnaire> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('first_exam')) {
      context.handle(_firstExamMeta,
          firstExam.isAcceptableOrUnknown(data['first_exam']!, _firstExamMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {type};
  @override
  ExaminationQuestionnaire map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ExaminationQuestionnaire.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ExaminationQuestionnairesTable createAlias(String alias) {
    return $ExaminationQuestionnairesTable(_db, alias);
  }

  static TypeConverter<ExaminationTypeEnum, String> $converter0 =
      const ExaminationTypeEnumDbConverter();
  static TypeConverter<ExaminationStatus, String> $converter1 =
      const ExaminationStatusDbConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $HealthcareProvidersTable healthcareProviders =
      $HealthcareProvidersTable(this);
  late final $CalendarEventsTable calendarEvents = $CalendarEventsTable(this);
  late final $ExaminationQuestionnairesTable examinationQuestionnaires =
      $ExaminationQuestionnairesTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final HealthcareProvidersDao healthcareProvidersDao =
      HealthcareProvidersDao(this as AppDatabase);
  late final CalendarEventsDao calendarEventsDao =
      CalendarEventsDao(this as AppDatabase);
  late final ExaminationQuestionnairesDao examinationQuestionnairesDao =
      ExaminationQuestionnairesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, healthcareProviders, calendarEvents, examinationQuestionnaires];
}
