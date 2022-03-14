// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String id;
  final Sex? sex;
  final DateWithoutDay? dateOfBirth;
  final String? nickname;
  final String? email;
  final String? profileImageUrl;
  final String? defaultDeviceCalendarId;
  final DateTime? latestMapUpdateCheck;
  final DateTime? latestMapUpdate;
  final List<SearchResult> searchHistory;
  final int points;
  final BuiltList<Badge> badges;
  User(
      {required this.id,
      this.sex,
      this.dateOfBirth,
      this.nickname,
      this.email,
      this.profileImageUrl,
      this.defaultDeviceCalendarId,
      this.latestMapUpdateCheck,
      this.latestMapUpdate,
      required this.searchHistory,
      required this.points,
      required this.badges});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sex: $UsersTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sex'])),
      dateOfBirth: $UsersTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_of_birth'])),
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
      searchHistory: $UsersTable.$converter2.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}search_history']))!,
      points: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}points'])!,
      badges: $UsersTable.$converter3.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}badges']))!,
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
    if (!nullToAbsent || dateOfBirth != null) {
      final converter = $UsersTable.$converter1;
      map['date_of_birth'] = Variable<String?>(converter.mapToSql(dateOfBirth));
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
    {
      final converter = $UsersTable.$converter2;
      map['search_history'] =
          Variable<String>(converter.mapToSql(searchHistory)!);
    }
    map['points'] = Variable<int>(points);
    {
      final converter = $UsersTable.$converter3;
      map['badges'] = Variable<String>(converter.mapToSql(badges)!);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
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
      searchHistory: Value(searchHistory),
      points: Value(points),
      badges: Value(badges),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      sex: serializer.fromJson<Sex?>(json['sex']),
      dateOfBirth: serializer.fromJson<DateWithoutDay?>(json['dateOfBirth']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      email: serializer.fromJson<String?>(json['email']),
      profileImageUrl: serializer.fromJson<String?>(json['profileImageUrl']),
      defaultDeviceCalendarId:
          serializer.fromJson<String?>(json['defaultDeviceCalendarId']),
      latestMapUpdateCheck:
          serializer.fromJson<DateTime?>(json['latestMapUpdateCheck']),
      latestMapUpdate: serializer.fromJson<DateTime?>(json['latestMapUpdate']),
      searchHistory:
          serializer.fromJson<List<SearchResult>>(json['searchHistory']),
      points: serializer.fromJson<int>(json['points']),
      badges: serializer.fromJson<BuiltList<Badge>>(json['badges']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sex': serializer.toJson<Sex?>(sex),
      'dateOfBirth': serializer.toJson<DateWithoutDay?>(dateOfBirth),
      'nickname': serializer.toJson<String?>(nickname),
      'email': serializer.toJson<String?>(email),
      'profileImageUrl': serializer.toJson<String?>(profileImageUrl),
      'defaultDeviceCalendarId':
          serializer.toJson<String?>(defaultDeviceCalendarId),
      'latestMapUpdateCheck':
          serializer.toJson<DateTime?>(latestMapUpdateCheck),
      'latestMapUpdate': serializer.toJson<DateTime?>(latestMapUpdate),
      'searchHistory': serializer.toJson<List<SearchResult>>(searchHistory),
      'points': serializer.toJson<int>(points),
      'badges': serializer.toJson<BuiltList<Badge>>(badges),
    };
  }

  User copyWith(
          {String? id,
          Sex? sex,
          DateWithoutDay? dateOfBirth,
          String? nickname,
          String? email,
          String? profileImageUrl,
          String? defaultDeviceCalendarId,
          DateTime? latestMapUpdateCheck,
          DateTime? latestMapUpdate,
          List<SearchResult>? searchHistory,
          int? points,
          BuiltList<Badge>? badges}) =>
      User(
        id: id ?? this.id,
        sex: sex ?? this.sex,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        defaultDeviceCalendarId:
            defaultDeviceCalendarId ?? this.defaultDeviceCalendarId,
        latestMapUpdateCheck: latestMapUpdateCheck ?? this.latestMapUpdateCheck,
        latestMapUpdate: latestMapUpdate ?? this.latestMapUpdate,
        searchHistory: searchHistory ?? this.searchHistory,
        points: points ?? this.points,
        badges: badges ?? this.badges,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('defaultDeviceCalendarId: $defaultDeviceCalendarId, ')
          ..write('latestMapUpdateCheck: $latestMapUpdateCheck, ')
          ..write('latestMapUpdate: $latestMapUpdate, ')
          ..write('searchHistory: $searchHistory, ')
          ..write('points: $points, ')
          ..write('badges: $badges')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sex,
      dateOfBirth,
      nickname,
      email,
      profileImageUrl,
      defaultDeviceCalendarId,
      latestMapUpdateCheck,
      latestMapUpdate,
      searchHistory,
      points,
      badges);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.dateOfBirth == this.dateOfBirth &&
          other.nickname == this.nickname &&
          other.email == this.email &&
          other.profileImageUrl == this.profileImageUrl &&
          other.defaultDeviceCalendarId == this.defaultDeviceCalendarId &&
          other.latestMapUpdateCheck == this.latestMapUpdateCheck &&
          other.latestMapUpdate == this.latestMapUpdate &&
          other.searchHistory == this.searchHistory &&
          other.points == this.points &&
          other.badges == this.badges);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<Sex?> sex;
  final Value<DateWithoutDay?> dateOfBirth;
  final Value<String?> nickname;
  final Value<String?> email;
  final Value<String?> profileImageUrl;
  final Value<String?> defaultDeviceCalendarId;
  final Value<DateTime?> latestMapUpdateCheck;
  final Value<DateTime?> latestMapUpdate;
  final Value<List<SearchResult>> searchHistory;
  final Value<int> points;
  final Value<BuiltList<Badge>> badges;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.defaultDeviceCalendarId = const Value.absent(),
    this.latestMapUpdateCheck = const Value.absent(),
    this.latestMapUpdate = const Value.absent(),
    this.searchHistory = const Value.absent(),
    this.points = const Value.absent(),
    this.badges = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.defaultDeviceCalendarId = const Value.absent(),
    this.latestMapUpdateCheck = const Value.absent(),
    this.latestMapUpdate = const Value.absent(),
    this.searchHistory = const Value.absent(),
    this.points = const Value.absent(),
    this.badges = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<Sex?>? sex,
    Expression<DateWithoutDay?>? dateOfBirth,
    Expression<String?>? nickname,
    Expression<String?>? email,
    Expression<String?>? profileImageUrl,
    Expression<String?>? defaultDeviceCalendarId,
    Expression<DateTime?>? latestMapUpdateCheck,
    Expression<DateTime?>? latestMapUpdate,
    Expression<List<SearchResult>>? searchHistory,
    Expression<int>? points,
    Expression<BuiltList<Badge>>? badges,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (nickname != null) 'nickname': nickname,
      if (email != null) 'email': email,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      if (defaultDeviceCalendarId != null)
        'default_device_calendar_id': defaultDeviceCalendarId,
      if (latestMapUpdateCheck != null)
        'latest_map_update_check': latestMapUpdateCheck,
      if (latestMapUpdate != null) 'latest_map_update': latestMapUpdate,
      if (searchHistory != null) 'search_history': searchHistory,
      if (points != null) 'points': points,
      if (badges != null) 'badges': badges,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<Sex?>? sex,
      Value<DateWithoutDay?>? dateOfBirth,
      Value<String?>? nickname,
      Value<String?>? email,
      Value<String?>? profileImageUrl,
      Value<String?>? defaultDeviceCalendarId,
      Value<DateTime?>? latestMapUpdateCheck,
      Value<DateTime?>? latestMapUpdate,
      Value<List<SearchResult>>? searchHistory,
      Value<int>? points,
      Value<BuiltList<Badge>>? badges}) {
    return UsersCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      defaultDeviceCalendarId:
          defaultDeviceCalendarId ?? this.defaultDeviceCalendarId,
      latestMapUpdateCheck: latestMapUpdateCheck ?? this.latestMapUpdateCheck,
      latestMapUpdate: latestMapUpdate ?? this.latestMapUpdate,
      searchHistory: searchHistory ?? this.searchHistory,
      points: points ?? this.points,
      badges: badges ?? this.badges,
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
    if (dateOfBirth.present) {
      final converter = $UsersTable.$converter1;
      map['date_of_birth'] =
          Variable<String?>(converter.mapToSql(dateOfBirth.value));
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
    if (searchHistory.present) {
      final converter = $UsersTable.$converter2;
      map['search_history'] =
          Variable<String>(converter.mapToSql(searchHistory.value)!);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (badges.present) {
      final converter = $UsersTable.$converter3;
      map['badges'] = Variable<String>(converter.mapToSql(badges.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('defaultDeviceCalendarId: $defaultDeviceCalendarId, ')
          ..write('latestMapUpdateCheck: $latestMapUpdateCheck, ')
          ..write('latestMapUpdate: $latestMapUpdate, ')
          ..write('searchHistory: $searchHistory, ')
          ..write('points: $points, ')
          ..write('badges: $badges')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      clientDefault: () => uuid.v4());
  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumnWithTypeConverter<Sex, String?> sex =
      GeneratedColumn<String?>('sex', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Sex>($UsersTable.$converter0);
  final VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumnWithTypeConverter<DateWithoutDay, String?>
      dateOfBirth = GeneratedColumn<String?>('date_of_birth', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<DateWithoutDay>($UsersTable.$converter1);
  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String?> nickname = GeneratedColumn<String?>(
      'nickname', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _profileImageUrlMeta =
      const VerificationMeta('profileImageUrl');
  @override
  late final GeneratedColumn<String?> profileImageUrl =
      GeneratedColumn<String?>('profile_image_url', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _defaultDeviceCalendarIdMeta =
      const VerificationMeta('defaultDeviceCalendarId');
  @override
  late final GeneratedColumn<String?> defaultDeviceCalendarId =
      GeneratedColumn<String?>('default_device_calendar_id', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _latestMapUpdateCheckMeta =
      const VerificationMeta('latestMapUpdateCheck');
  @override
  late final GeneratedColumn<DateTime?> latestMapUpdateCheck =
      GeneratedColumn<DateTime?>('latest_map_update_check', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _latestMapUpdateMeta =
      const VerificationMeta('latestMapUpdate');
  @override
  late final GeneratedColumn<DateTime?> latestMapUpdate =
      GeneratedColumn<DateTime?>('latest_map_update', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _searchHistoryMeta =
      const VerificationMeta('searchHistory');
  @override
  late final GeneratedColumnWithTypeConverter<List<SearchResult>, String?>
      searchHistory = GeneratedColumn<String?>(
              'search_history', aliasedName, false,
              type: const StringType(),
              requiredDuringInsert: false,
              defaultValue: Constant(
                  const SearchHistoryDbConverter().mapToSql(<SearchResult>[])!))
          .withConverter<List<SearchResult>>($UsersTable.$converter2);
  final VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int?> points = GeneratedColumn<int?>(
      'points', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _badgesMeta = const VerificationMeta('badges');
  @override
  late final GeneratedColumnWithTypeConverter<BuiltList<Badge>, String?>
      badges = GeneratedColumn<String?>('badges', aliasedName, false,
              type: const StringType(),
              requiredDuringInsert: false,
              defaultValue: Constant(const BadgeListDbConverter()
                  .mapToSql(BuiltList.of(<Badge>[]))!))
          .withConverter<BuiltList<Badge>>($UsersTable.$converter3);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sex,
        dateOfBirth,
        nickname,
        email,
        profileImageUrl,
        defaultDeviceCalendarId,
        latestMapUpdateCheck,
        latestMapUpdate,
        searchHistory,
        points,
        badges
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
    }
    context.handle(_sexMeta, const VerificationResult.success());
    context.handle(_dateOfBirthMeta, const VerificationResult.success());
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
    context.handle(_searchHistoryMeta, const VerificationResult.success());
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    }
    context.handle(_badgesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<Sex, String> $converter0 = const SexDbConverter();
  static TypeConverter<DateWithoutDay, String> $converter1 =
      const DateOfBirthDbConverter();
  static TypeConverter<List<SearchResult>, String> $converter2 =
      const SearchHistoryDbConverter();
  static TypeConverter<BuiltList<Badge>, String> $converter3 =
      const BadgeListDbConverter();
}

class CalendarEvent extends DataClass implements Insertable<CalendarEvent> {
  final ExaminationType type;
  final String deviceCalendarId;
  final String calendarEventId;
  final DateTime date;
  CalendarEvent(
      {required this.type,
      required this.deviceCalendarId,
      required this.calendarEventId,
      required this.date});
  factory CalendarEvent.fromData(Map<String, dynamic> data, {String? prefix}) {
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarEvent(
      type: serializer.fromJson<ExaminationType>(json['type']),
      deviceCalendarId: serializer.fromJson<String>(json['deviceCalendarId']),
      calendarEventId: serializer.fromJson<String>(json['calendarEventId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<ExaminationType>(type),
      'deviceCalendarId': serializer.toJson<String>(deviceCalendarId),
      'calendarEventId': serializer.toJson<String>(calendarEventId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  CalendarEvent copyWith(
          {ExaminationType? type,
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
  int get hashCode =>
      Object.hash(type, deviceCalendarId, calendarEventId, date);
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
  final Value<ExaminationType> type;
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
    required ExaminationType type,
    required String deviceCalendarId,
    required String calendarEventId,
    required DateTime date,
  })  : type = Value(type),
        deviceCalendarId = Value(deviceCalendarId),
        calendarEventId = Value(calendarEventId),
        date = Value(date);
  static Insertable<CalendarEvent> custom({
    Expression<ExaminationType>? type,
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
      {Value<ExaminationType>? type,
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarEventsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ExaminationType, String?> type =
      GeneratedColumn<String?>('type', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<ExaminationType>($CalendarEventsTable.$converter0);
  final VerificationMeta _deviceCalendarIdMeta =
      const VerificationMeta('deviceCalendarId');
  @override
  late final GeneratedColumn<String?> deviceCalendarId =
      GeneratedColumn<String?>('device_calendar_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _calendarEventIdMeta =
      const VerificationMeta('calendarEventId');
  @override
  late final GeneratedColumn<String?> calendarEventId =
      GeneratedColumn<String?>('calendar_event_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
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
    return CalendarEvent.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CalendarEventsTable createAlias(String alias) {
    return $CalendarEventsTable(attachedDatabase, alias);
  }

  static TypeConverter<ExaminationType, String> $converter0 =
      const ExaminationTypeDbConverter();
}

class ExaminationQuestionnaire extends DataClass
    implements Insertable<ExaminationQuestionnaire> {
  final ExaminationType type;
  final ExaminationStatus status;
  final DateTime? date;
  final bool? firstExam;
  ExaminationQuestionnaire(
      {required this.type, required this.status, this.date, this.firstExam});
  factory ExaminationQuestionnaire.fromData(Map<String, dynamic> data,
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
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExaminationQuestionnaire(
      type: serializer.fromJson<ExaminationType>(json['type']),
      status: serializer.fromJson<ExaminationStatus>(json['status']),
      date: serializer.fromJson<DateTime?>(json['date']),
      firstExam: serializer.fromJson<bool?>(json['firstExam']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<ExaminationType>(type),
      'status': serializer.toJson<ExaminationStatus>(status),
      'date': serializer.toJson<DateTime?>(date),
      'firstExam': serializer.toJson<bool?>(firstExam),
    };
  }

  ExaminationQuestionnaire copyWith(
          {ExaminationType? type,
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
  int get hashCode => Object.hash(type, status, date, firstExam);
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
  final Value<ExaminationType> type;
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
    required ExaminationType type,
    this.status = const Value.absent(),
    this.date = const Value.absent(),
    this.firstExam = const Value.absent(),
  }) : type = Value(type);
  static Insertable<ExaminationQuestionnaire> custom({
    Expression<ExaminationType>? type,
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
      {Value<ExaminationType>? type,
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExaminationQuestionnairesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ExaminationType, String?> type =
      GeneratedColumn<String?>('type', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<ExaminationType>(
              $ExaminationQuestionnairesTable.$converter0);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<ExaminationStatus, String?>
      status = GeneratedColumn<String?>('status', aliasedName, false,
              type: const StringType(),
              requiredDuringInsert: false,
              defaultValue: Constant(const ExaminationStatusDbConverter()
                  .mapToSql(ExaminationStatus.NEW)!))
          .withConverter<ExaminationStatus>(
              $ExaminationQuestionnairesTable.$converter1);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _firstExamMeta = const VerificationMeta('firstExam');
  @override
  late final GeneratedColumn<bool?> firstExam = GeneratedColumn<bool?>(
      'first_exam', aliasedName, true,
      type: const BoolType(),
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
    return ExaminationQuestionnaire.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ExaminationQuestionnairesTable createAlias(String alias) {
    return $ExaminationQuestionnairesTable(attachedDatabase, alias);
  }

  static TypeConverter<ExaminationType, String> $converter0 =
      const ExaminationTypeDbConverter();
  static TypeConverter<ExaminationStatus, String> $converter1 =
      const ExaminationStatusDbConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $CalendarEventsTable calendarEvents = $CalendarEventsTable(this);
  late final $ExaminationQuestionnairesTable examinationQuestionnaires =
      $ExaminationQuestionnairesTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final CalendarEventsDao calendarEventsDao =
      CalendarEventsDao(this as AppDatabase);
  late final ExaminationQuestionnairesDao examinationQuestionnairesDao =
      ExaminationQuestionnairesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, calendarEvents, examinationQuestionnaires];
}
