// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String id;
  final int? sexRaw;
  final String? dateOfBirthRaw;
  final int? generalPracticionerCcaVisitRaw;
  final String? generalPracticionerVisitDateRaw;
  final int? gynecologyCcaVisitRaw;
  final String? gynecologyVisitDateRaw;
  final int? dentistCcaVisitRaw;
  final String? dentistVisitDateRaw;
  final String? nickname;
  final String? email;
  User(
      {required this.id,
      this.sexRaw,
      this.dateOfBirthRaw,
      this.generalPracticionerCcaVisitRaw,
      this.generalPracticionerVisitDateRaw,
      this.gynecologyCcaVisitRaw,
      this.gynecologyVisitDateRaw,
      this.dentistCcaVisitRaw,
      this.dentistVisitDateRaw,
      this.nickname,
      this.email});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sexRaw: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sex_raw']),
      dateOfBirthRaw: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_of_birth_raw']),
      generalPracticionerCcaVisitRaw: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}general_practicioner_cca_visit_raw']),
      generalPracticionerVisitDateRaw: const StringType()
          .mapFromDatabaseResponse(
              data['${effectivePrefix}general_practicioner_visit_date_raw']),
      gynecologyCcaVisitRaw: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}gynecology_cca_visit_raw']),
      gynecologyVisitDateRaw: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}gynecology_visit_date_raw']),
      dentistCcaVisitRaw: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}dentist_cca_visit_raw']),
      dentistVisitDateRaw: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}dentist_visit_date_raw']),
      nickname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nickname']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sexRaw != null) {
      map['sex_raw'] = Variable<int?>(sexRaw);
    }
    if (!nullToAbsent || dateOfBirthRaw != null) {
      map['date_of_birth_raw'] = Variable<String?>(dateOfBirthRaw);
    }
    if (!nullToAbsent || generalPracticionerCcaVisitRaw != null) {
      map['general_practicioner_cca_visit_raw'] =
          Variable<int?>(generalPracticionerCcaVisitRaw);
    }
    if (!nullToAbsent || generalPracticionerVisitDateRaw != null) {
      map['general_practicioner_visit_date_raw'] =
          Variable<String?>(generalPracticionerVisitDateRaw);
    }
    if (!nullToAbsent || gynecologyCcaVisitRaw != null) {
      map['gynecology_cca_visit_raw'] = Variable<int?>(gynecologyCcaVisitRaw);
    }
    if (!nullToAbsent || gynecologyVisitDateRaw != null) {
      map['gynecology_visit_date_raw'] =
          Variable<String?>(gynecologyVisitDateRaw);
    }
    if (!nullToAbsent || dentistCcaVisitRaw != null) {
      map['dentist_cca_visit_raw'] = Variable<int?>(dentistCcaVisitRaw);
    }
    if (!nullToAbsent || dentistVisitDateRaw != null) {
      map['dentist_visit_date_raw'] = Variable<String?>(dentistVisitDateRaw);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String?>(nickname);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      sexRaw:
          sexRaw == null && nullToAbsent ? const Value.absent() : Value(sexRaw),
      dateOfBirthRaw: dateOfBirthRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirthRaw),
      generalPracticionerCcaVisitRaw:
          generalPracticionerCcaVisitRaw == null && nullToAbsent
              ? const Value.absent()
              : Value(generalPracticionerCcaVisitRaw),
      generalPracticionerVisitDateRaw:
          generalPracticionerVisitDateRaw == null && nullToAbsent
              ? const Value.absent()
              : Value(generalPracticionerVisitDateRaw),
      gynecologyCcaVisitRaw: gynecologyCcaVisitRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(gynecologyCcaVisitRaw),
      gynecologyVisitDateRaw: gynecologyVisitDateRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(gynecologyVisitDateRaw),
      dentistCcaVisitRaw: dentistCcaVisitRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(dentistCcaVisitRaw),
      dentistVisitDateRaw: dentistVisitDateRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(dentistVisitDateRaw),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      sexRaw: serializer.fromJson<int?>(json['sexRaw']),
      dateOfBirthRaw: serializer.fromJson<String?>(json['dateOfBirthRaw']),
      generalPracticionerCcaVisitRaw:
          serializer.fromJson<int?>(json['generalPracticionerCcaVisitRaw']),
      generalPracticionerVisitDateRaw:
          serializer.fromJson<String?>(json['generalPracticionerVisitDateRaw']),
      gynecologyCcaVisitRaw:
          serializer.fromJson<int?>(json['gynecologyCcaVisitRaw']),
      gynecologyVisitDateRaw:
          serializer.fromJson<String?>(json['gynecologyVisitDateRaw']),
      dentistCcaVisitRaw: serializer.fromJson<int?>(json['dentistCcaVisitRaw']),
      dentistVisitDateRaw:
          serializer.fromJson<String?>(json['dentistVisitDateRaw']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sexRaw': serializer.toJson<int?>(sexRaw),
      'dateOfBirthRaw': serializer.toJson<String?>(dateOfBirthRaw),
      'generalPracticionerCcaVisitRaw':
          serializer.toJson<int?>(generalPracticionerCcaVisitRaw),
      'generalPracticionerVisitDateRaw':
          serializer.toJson<String?>(generalPracticionerVisitDateRaw),
      'gynecologyCcaVisitRaw': serializer.toJson<int?>(gynecologyCcaVisitRaw),
      'gynecologyVisitDateRaw':
          serializer.toJson<String?>(gynecologyVisitDateRaw),
      'dentistCcaVisitRaw': serializer.toJson<int?>(dentistCcaVisitRaw),
      'dentistVisitDateRaw': serializer.toJson<String?>(dentistVisitDateRaw),
      'nickname': serializer.toJson<String?>(nickname),
      'email': serializer.toJson<String?>(email),
    };
  }

  User copyWith(
          {String? id,
          int? sexRaw,
          String? dateOfBirthRaw,
          int? generalPracticionerCcaVisitRaw,
          String? generalPracticionerVisitDateRaw,
          int? gynecologyCcaVisitRaw,
          String? gynecologyVisitDateRaw,
          int? dentistCcaVisitRaw,
          String? dentistVisitDateRaw,
          String? nickname,
          String? email}) =>
      User(
        id: id ?? this.id,
        sexRaw: sexRaw ?? this.sexRaw,
        dateOfBirthRaw: dateOfBirthRaw ?? this.dateOfBirthRaw,
        generalPracticionerCcaVisitRaw: generalPracticionerCcaVisitRaw ??
            this.generalPracticionerCcaVisitRaw,
        generalPracticionerVisitDateRaw: generalPracticionerVisitDateRaw ??
            this.generalPracticionerVisitDateRaw,
        gynecologyCcaVisitRaw:
            gynecologyCcaVisitRaw ?? this.gynecologyCcaVisitRaw,
        gynecologyVisitDateRaw:
            gynecologyVisitDateRaw ?? this.gynecologyVisitDateRaw,
        dentistCcaVisitRaw: dentistCcaVisitRaw ?? this.dentistCcaVisitRaw,
        dentistVisitDateRaw: dentistVisitDateRaw ?? this.dentistVisitDateRaw,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('sexRaw: $sexRaw, ')
          ..write('dateOfBirthRaw: $dateOfBirthRaw, ')
          ..write(
              'generalPracticionerCcaVisitRaw: $generalPracticionerCcaVisitRaw, ')
          ..write(
              'generalPracticionerVisitDateRaw: $generalPracticionerVisitDateRaw, ')
          ..write('gynecologyCcaVisitRaw: $gynecologyCcaVisitRaw, ')
          ..write('gynecologyVisitDateRaw: $gynecologyVisitDateRaw, ')
          ..write('dentistCcaVisitRaw: $dentistCcaVisitRaw, ')
          ..write('dentistVisitDateRaw: $dentistVisitDateRaw, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          sexRaw.hashCode,
          $mrjc(
              dateOfBirthRaw.hashCode,
              $mrjc(
                  generalPracticionerCcaVisitRaw.hashCode,
                  $mrjc(
                      generalPracticionerVisitDateRaw.hashCode,
                      $mrjc(
                          gynecologyCcaVisitRaw.hashCode,
                          $mrjc(
                              gynecologyVisitDateRaw.hashCode,
                              $mrjc(
                                  dentistCcaVisitRaw.hashCode,
                                  $mrjc(
                                      dentistVisitDateRaw.hashCode,
                                      $mrjc(nickname.hashCode,
                                          email.hashCode)))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.sexRaw == this.sexRaw &&
          other.dateOfBirthRaw == this.dateOfBirthRaw &&
          other.generalPracticionerCcaVisitRaw ==
              this.generalPracticionerCcaVisitRaw &&
          other.generalPracticionerVisitDateRaw ==
              this.generalPracticionerVisitDateRaw &&
          other.gynecologyCcaVisitRaw == this.gynecologyCcaVisitRaw &&
          other.gynecologyVisitDateRaw == this.gynecologyVisitDateRaw &&
          other.dentistCcaVisitRaw == this.dentistCcaVisitRaw &&
          other.dentistVisitDateRaw == this.dentistVisitDateRaw &&
          other.nickname == this.nickname &&
          other.email == this.email);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<int?> sexRaw;
  final Value<String?> dateOfBirthRaw;
  final Value<int?> generalPracticionerCcaVisitRaw;
  final Value<String?> generalPracticionerVisitDateRaw;
  final Value<int?> gynecologyCcaVisitRaw;
  final Value<String?> gynecologyVisitDateRaw;
  final Value<int?> dentistCcaVisitRaw;
  final Value<String?> dentistVisitDateRaw;
  final Value<String?> nickname;
  final Value<String?> email;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.sexRaw = const Value.absent(),
    this.dateOfBirthRaw = const Value.absent(),
    this.generalPracticionerCcaVisitRaw = const Value.absent(),
    this.generalPracticionerVisitDateRaw = const Value.absent(),
    this.gynecologyCcaVisitRaw = const Value.absent(),
    this.gynecologyVisitDateRaw = const Value.absent(),
    this.dentistCcaVisitRaw = const Value.absent(),
    this.dentistVisitDateRaw = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.sexRaw = const Value.absent(),
    this.dateOfBirthRaw = const Value.absent(),
    this.generalPracticionerCcaVisitRaw = const Value.absent(),
    this.generalPracticionerVisitDateRaw = const Value.absent(),
    this.gynecologyCcaVisitRaw = const Value.absent(),
    this.gynecologyVisitDateRaw = const Value.absent(),
    this.dentistCcaVisitRaw = const Value.absent(),
    this.dentistVisitDateRaw = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<int?>? sexRaw,
    Expression<String?>? dateOfBirthRaw,
    Expression<int?>? generalPracticionerCcaVisitRaw,
    Expression<String?>? generalPracticionerVisitDateRaw,
    Expression<int?>? gynecologyCcaVisitRaw,
    Expression<String?>? gynecologyVisitDateRaw,
    Expression<int?>? dentistCcaVisitRaw,
    Expression<String?>? dentistVisitDateRaw,
    Expression<String?>? nickname,
    Expression<String?>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sexRaw != null) 'sex_raw': sexRaw,
      if (dateOfBirthRaw != null) 'date_of_birth_raw': dateOfBirthRaw,
      if (generalPracticionerCcaVisitRaw != null)
        'general_practicioner_cca_visit_raw': generalPracticionerCcaVisitRaw,
      if (generalPracticionerVisitDateRaw != null)
        'general_practicioner_visit_date_raw': generalPracticionerVisitDateRaw,
      if (gynecologyCcaVisitRaw != null)
        'gynecology_cca_visit_raw': gynecologyCcaVisitRaw,
      if (gynecologyVisitDateRaw != null)
        'gynecology_visit_date_raw': gynecologyVisitDateRaw,
      if (dentistCcaVisitRaw != null)
        'dentist_cca_visit_raw': dentistCcaVisitRaw,
      if (dentistVisitDateRaw != null)
        'dentist_visit_date_raw': dentistVisitDateRaw,
      if (nickname != null) 'nickname': nickname,
      if (email != null) 'email': email,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<int?>? sexRaw,
      Value<String?>? dateOfBirthRaw,
      Value<int?>? generalPracticionerCcaVisitRaw,
      Value<String?>? generalPracticionerVisitDateRaw,
      Value<int?>? gynecologyCcaVisitRaw,
      Value<String?>? gynecologyVisitDateRaw,
      Value<int?>? dentistCcaVisitRaw,
      Value<String?>? dentistVisitDateRaw,
      Value<String?>? nickname,
      Value<String?>? email}) {
    return UsersCompanion(
      id: id ?? this.id,
      sexRaw: sexRaw ?? this.sexRaw,
      dateOfBirthRaw: dateOfBirthRaw ?? this.dateOfBirthRaw,
      generalPracticionerCcaVisitRaw:
          generalPracticionerCcaVisitRaw ?? this.generalPracticionerCcaVisitRaw,
      generalPracticionerVisitDateRaw: generalPracticionerVisitDateRaw ??
          this.generalPracticionerVisitDateRaw,
      gynecologyCcaVisitRaw:
          gynecologyCcaVisitRaw ?? this.gynecologyCcaVisitRaw,
      gynecologyVisitDateRaw:
          gynecologyVisitDateRaw ?? this.gynecologyVisitDateRaw,
      dentistCcaVisitRaw: dentistCcaVisitRaw ?? this.dentistCcaVisitRaw,
      dentistVisitDateRaw: dentistVisitDateRaw ?? this.dentistVisitDateRaw,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sexRaw.present) {
      map['sex_raw'] = Variable<int?>(sexRaw.value);
    }
    if (dateOfBirthRaw.present) {
      map['date_of_birth_raw'] = Variable<String?>(dateOfBirthRaw.value);
    }
    if (generalPracticionerCcaVisitRaw.present) {
      map['general_practicioner_cca_visit_raw'] =
          Variable<int?>(generalPracticionerCcaVisitRaw.value);
    }
    if (generalPracticionerVisitDateRaw.present) {
      map['general_practicioner_visit_date_raw'] =
          Variable<String?>(generalPracticionerVisitDateRaw.value);
    }
    if (gynecologyCcaVisitRaw.present) {
      map['gynecology_cca_visit_raw'] =
          Variable<int?>(gynecologyCcaVisitRaw.value);
    }
    if (gynecologyVisitDateRaw.present) {
      map['gynecology_visit_date_raw'] =
          Variable<String?>(gynecologyVisitDateRaw.value);
    }
    if (dentistCcaVisitRaw.present) {
      map['dentist_cca_visit_raw'] = Variable<int?>(dentistCcaVisitRaw.value);
    }
    if (dentistVisitDateRaw.present) {
      map['dentist_visit_date_raw'] =
          Variable<String?>(dentistVisitDateRaw.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String?>(nickname.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('sexRaw: $sexRaw, ')
          ..write('dateOfBirthRaw: $dateOfBirthRaw, ')
          ..write(
              'generalPracticionerCcaVisitRaw: $generalPracticionerCcaVisitRaw, ')
          ..write(
              'generalPracticionerVisitDateRaw: $generalPracticionerVisitDateRaw, ')
          ..write('gynecologyCcaVisitRaw: $gynecologyCcaVisitRaw, ')
          ..write('gynecologyVisitDateRaw: $gynecologyVisitDateRaw, ')
          ..write('dentistCcaVisitRaw: $dentistCcaVisitRaw, ')
          ..write('dentistVisitDateRaw: $dentistVisitDateRaw, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email')
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
  final VerificationMeta _sexRawMeta = const VerificationMeta('sexRaw');
  late final GeneratedColumn<int?> sexRaw = GeneratedColumn<int?>(
      'sex_raw', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dateOfBirthRawMeta =
      const VerificationMeta('dateOfBirthRaw');
  late final GeneratedColumn<String?> dateOfBirthRaw = GeneratedColumn<String?>(
      'date_of_birth_raw', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _generalPracticionerCcaVisitRawMeta =
      const VerificationMeta('generalPracticionerCcaVisitRaw');
  late final GeneratedColumn<int?> generalPracticionerCcaVisitRaw =
      GeneratedColumn<int?>(
          'general_practicioner_cca_visit_raw', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _generalPracticionerVisitDateRawMeta =
      const VerificationMeta('generalPracticionerVisitDateRaw');
  late final GeneratedColumn<String?> generalPracticionerVisitDateRaw =
      GeneratedColumn<String?>(
          'general_practicioner_visit_date_raw', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _gynecologyCcaVisitRawMeta =
      const VerificationMeta('gynecologyCcaVisitRaw');
  late final GeneratedColumn<int?> gynecologyCcaVisitRaw =
      GeneratedColumn<int?>('gynecology_cca_visit_raw', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _gynecologyVisitDateRawMeta =
      const VerificationMeta('gynecologyVisitDateRaw');
  late final GeneratedColumn<String?> gynecologyVisitDateRaw =
      GeneratedColumn<String?>('gynecology_visit_date_raw', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dentistCcaVisitRawMeta =
      const VerificationMeta('dentistCcaVisitRaw');
  late final GeneratedColumn<int?> dentistCcaVisitRaw = GeneratedColumn<int?>(
      'dentist_cca_visit_raw', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dentistVisitDateRawMeta =
      const VerificationMeta('dentistVisitDateRaw');
  late final GeneratedColumn<String?> dentistVisitDateRaw =
      GeneratedColumn<String?>('dentist_visit_date_raw', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  late final GeneratedColumn<String?> nickname = GeneratedColumn<String?>(
      'nickname', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sexRaw,
        dateOfBirthRaw,
        generalPracticionerCcaVisitRaw,
        generalPracticionerVisitDateRaw,
        gynecologyCcaVisitRaw,
        gynecologyVisitDateRaw,
        dentistCcaVisitRaw,
        dentistVisitDateRaw,
        nickname,
        email
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
    if (data.containsKey('sex_raw')) {
      context.handle(_sexRawMeta,
          sexRaw.isAcceptableOrUnknown(data['sex_raw']!, _sexRawMeta));
    }
    if (data.containsKey('date_of_birth_raw')) {
      context.handle(
          _dateOfBirthRawMeta,
          dateOfBirthRaw.isAcceptableOrUnknown(
              data['date_of_birth_raw']!, _dateOfBirthRawMeta));
    }
    if (data.containsKey('general_practicioner_cca_visit_raw')) {
      context.handle(
          _generalPracticionerCcaVisitRawMeta,
          generalPracticionerCcaVisitRaw.isAcceptableOrUnknown(
              data['general_practicioner_cca_visit_raw']!,
              _generalPracticionerCcaVisitRawMeta));
    }
    if (data.containsKey('general_practicioner_visit_date_raw')) {
      context.handle(
          _generalPracticionerVisitDateRawMeta,
          generalPracticionerVisitDateRaw.isAcceptableOrUnknown(
              data['general_practicioner_visit_date_raw']!,
              _generalPracticionerVisitDateRawMeta));
    }
    if (data.containsKey('gynecology_cca_visit_raw')) {
      context.handle(
          _gynecologyCcaVisitRawMeta,
          gynecologyCcaVisitRaw.isAcceptableOrUnknown(
              data['gynecology_cca_visit_raw']!, _gynecologyCcaVisitRawMeta));
    }
    if (data.containsKey('gynecology_visit_date_raw')) {
      context.handle(
          _gynecologyVisitDateRawMeta,
          gynecologyVisitDateRaw.isAcceptableOrUnknown(
              data['gynecology_visit_date_raw']!, _gynecologyVisitDateRawMeta));
    }
    if (data.containsKey('dentist_cca_visit_raw')) {
      context.handle(
          _dentistCcaVisitRawMeta,
          dentistCcaVisitRaw.isAcceptableOrUnknown(
              data['dentist_cca_visit_raw']!, _dentistCcaVisitRawMeta));
    }
    if (data.containsKey('dentist_visit_date_raw')) {
      context.handle(
          _dentistVisitDateRawMeta,
          dentistVisitDateRaw.isAcceptableOrUnknown(
              data['dentist_visit_date_raw']!, _dentistVisitDateRawMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
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
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
