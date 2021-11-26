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
  final String? achievementCollectionRaw;
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
      this.email,
      this.achievementCollectionRaw});
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
      achievementCollectionRaw: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}achievement_collection_raw']),
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
    if (!nullToAbsent || achievementCollectionRaw != null) {
      map['achievement_collection_raw'] =
          Variable<String?>(achievementCollectionRaw);
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
      achievementCollectionRaw: achievementCollectionRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(achievementCollectionRaw),
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
      achievementCollectionRaw:
          serializer.fromJson<String?>(json['achievementCollectionRaw']),
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
      'achievementCollectionRaw':
          serializer.toJson<String?>(achievementCollectionRaw),
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
          String? email,
          String? achievementCollectionRaw}) =>
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
        achievementCollectionRaw:
            achievementCollectionRaw ?? this.achievementCollectionRaw,
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
          ..write('email: $email, ')
          ..write('achievementCollectionRaw: $achievementCollectionRaw')
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
                                      $mrjc(
                                          nickname.hashCode,
                                          $mrjc(
                                              email.hashCode,
                                              achievementCollectionRaw
                                                  .hashCode))))))))))));
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
          other.email == this.email &&
          other.achievementCollectionRaw == this.achievementCollectionRaw);
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
  final Value<String?> achievementCollectionRaw;
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
    this.achievementCollectionRaw = const Value.absent(),
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
    this.achievementCollectionRaw = const Value.absent(),
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
    Expression<String?>? achievementCollectionRaw,
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
      if (achievementCollectionRaw != null)
        'achievement_collection_raw': achievementCollectionRaw,
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
      Value<String?>? email,
      Value<String?>? achievementCollectionRaw}) {
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
      achievementCollectionRaw:
          achievementCollectionRaw ?? this.achievementCollectionRaw,
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
    if (achievementCollectionRaw.present) {
      map['achievement_collection_raw'] =
          Variable<String?>(achievementCollectionRaw.value);
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
          ..write('email: $email, ')
          ..write('achievementCollectionRaw: $achievementCollectionRaw')
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
  final VerificationMeta _achievementCollectionRawMeta =
      const VerificationMeta('achievementCollectionRaw');
  late final GeneratedColumn<String?> achievementCollectionRaw =
      GeneratedColumn<String?>('achievement_collection_raw', aliasedName, true,
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
        email,
        achievementCollectionRaw
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
    if (data.containsKey('achievement_collection_raw')) {
      context.handle(
          _achievementCollectionRawMeta,
          achievementCollectionRaw.isAcceptableOrUnknown(
              data['achievement_collection_raw']!,
              _achievementCollectionRawMeta));
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

class HealthcareProvider extends DataClass
    implements Insertable<HealthcareProvider> {
  final int locationId;
  final int institutionId;

  /// Provides a date of the this healthcare providers update.
  ///
  /// format: YYYY-MM-DD
  final String? updateDate;
  final String? title;
  final BuiltList<String>? category;
  final String? street;
  final String? specialization;
  final String? houseNumber;
  final String? city;
  final String? postalCode;
  final double lat;
  final double lng;
  HealthcareProvider(
      {required this.locationId,
      required this.institutionId,
      this.updateDate,
      this.title,
      this.category,
      this.street,
      this.specialization,
      this.houseNumber,
      this.city,
      this.postalCode,
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
      updateDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_date']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      category: $HealthcareProvidersTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}category'])),
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street']),
      specialization: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}specialization']),
      houseNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}house_number']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city']),
      postalCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}postal_code']),
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
    if (!nullToAbsent || updateDate != null) {
      map['update_date'] = Variable<String?>(updateDate);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || category != null) {
      final converter = $HealthcareProvidersTable.$converter0;
      map['category'] = Variable<String?>(converter.mapToSql(category));
    }
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String?>(street);
    }
    if (!nullToAbsent || specialization != null) {
      map['specialization'] = Variable<String?>(specialization);
    }
    if (!nullToAbsent || houseNumber != null) {
      map['house_number'] = Variable<String?>(houseNumber);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String?>(city);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String?>(postalCode);
    }
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  HealthcareProvidersCompanion toCompanion(bool nullToAbsent) {
    return HealthcareProvidersCompanion(
      locationId: Value(locationId),
      institutionId: Value(institutionId),
      updateDate: updateDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updateDate),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      specialization: specialization == null && nullToAbsent
          ? const Value.absent()
          : Value(specialization),
      houseNumber: houseNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(houseNumber),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
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
      updateDate: serializer.fromJson<String?>(json['updateDate']),
      title: serializer.fromJson<String?>(json['title']),
      category: serializer.fromJson<BuiltList<String>?>(json['category']),
      street: serializer.fromJson<String?>(json['street']),
      specialization: serializer.fromJson<String?>(json['specialization']),
      houseNumber: serializer.fromJson<String?>(json['houseNumber']),
      city: serializer.fromJson<String?>(json['city']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
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
      'updateDate': serializer.toJson<String?>(updateDate),
      'title': serializer.toJson<String?>(title),
      'category': serializer.toJson<BuiltList<String>?>(category),
      'street': serializer.toJson<String?>(street),
      'specialization': serializer.toJson<String?>(specialization),
      'houseNumber': serializer.toJson<String?>(houseNumber),
      'city': serializer.toJson<String?>(city),
      'postalCode': serializer.toJson<String?>(postalCode),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  HealthcareProvider copyWith(
          {int? locationId,
          int? institutionId,
          String? updateDate,
          String? title,
          BuiltList<String>? category,
          String? street,
          String? specialization,
          String? houseNumber,
          String? city,
          String? postalCode,
          double? lat,
          double? lng}) =>
      HealthcareProvider(
        locationId: locationId ?? this.locationId,
        institutionId: institutionId ?? this.institutionId,
        updateDate: updateDate ?? this.updateDate,
        title: title ?? this.title,
        category: category ?? this.category,
        street: street ?? this.street,
        specialization: specialization ?? this.specialization,
        houseNumber: houseNumber ?? this.houseNumber,
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
          ..write('updateDate: $updateDate, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('street: $street, ')
          ..write('specialization: $specialization, ')
          ..write('houseNumber: $houseNumber, ')
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
              updateDate.hashCode,
              $mrjc(
                  title.hashCode,
                  $mrjc(
                      category.hashCode,
                      $mrjc(
                          street.hashCode,
                          $mrjc(
                              specialization.hashCode,
                              $mrjc(
                                  houseNumber.hashCode,
                                  $mrjc(
                                      city.hashCode,
                                      $mrjc(
                                          postalCode.hashCode,
                                          $mrjc(lat.hashCode,
                                              lng.hashCode))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthcareProvider &&
          other.locationId == this.locationId &&
          other.institutionId == this.institutionId &&
          other.updateDate == this.updateDate &&
          other.title == this.title &&
          other.category == this.category &&
          other.street == this.street &&
          other.specialization == this.specialization &&
          other.houseNumber == this.houseNumber &&
          other.city == this.city &&
          other.postalCode == this.postalCode &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class HealthcareProvidersCompanion extends UpdateCompanion<HealthcareProvider> {
  final Value<int> locationId;
  final Value<int> institutionId;
  final Value<String?> updateDate;
  final Value<String?> title;
  final Value<BuiltList<String>?> category;
  final Value<String?> street;
  final Value<String?> specialization;
  final Value<String?> houseNumber;
  final Value<String?> city;
  final Value<String?> postalCode;
  final Value<double> lat;
  final Value<double> lng;
  const HealthcareProvidersCompanion({
    this.locationId = const Value.absent(),
    this.institutionId = const Value.absent(),
    this.updateDate = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.street = const Value.absent(),
    this.specialization = const Value.absent(),
    this.houseNumber = const Value.absent(),
    this.city = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  HealthcareProvidersCompanion.insert({
    required int locationId,
    required int institutionId,
    this.updateDate = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.street = const Value.absent(),
    this.specialization = const Value.absent(),
    this.houseNumber = const Value.absent(),
    this.city = const Value.absent(),
    this.postalCode = const Value.absent(),
    required double lat,
    required double lng,
  })  : locationId = Value(locationId),
        institutionId = Value(institutionId),
        lat = Value(lat),
        lng = Value(lng);
  static Insertable<HealthcareProvider> custom({
    Expression<int>? locationId,
    Expression<int>? institutionId,
    Expression<String?>? updateDate,
    Expression<String?>? title,
    Expression<BuiltList<String>?>? category,
    Expression<String?>? street,
    Expression<String?>? specialization,
    Expression<String?>? houseNumber,
    Expression<String?>? city,
    Expression<String?>? postalCode,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (locationId != null) 'location_id': locationId,
      if (institutionId != null) 'institution_id': institutionId,
      if (updateDate != null) 'update_date': updateDate,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (street != null) 'street': street,
      if (specialization != null) 'specialization': specialization,
      if (houseNumber != null) 'house_number': houseNumber,
      if (city != null) 'city': city,
      if (postalCode != null) 'postal_code': postalCode,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  HealthcareProvidersCompanion copyWith(
      {Value<int>? locationId,
      Value<int>? institutionId,
      Value<String?>? updateDate,
      Value<String?>? title,
      Value<BuiltList<String>?>? category,
      Value<String?>? street,
      Value<String?>? specialization,
      Value<String?>? houseNumber,
      Value<String?>? city,
      Value<String?>? postalCode,
      Value<double>? lat,
      Value<double>? lng}) {
    return HealthcareProvidersCompanion(
      locationId: locationId ?? this.locationId,
      institutionId: institutionId ?? this.institutionId,
      updateDate: updateDate ?? this.updateDate,
      title: title ?? this.title,
      category: category ?? this.category,
      street: street ?? this.street,
      specialization: specialization ?? this.specialization,
      houseNumber: houseNumber ?? this.houseNumber,
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
    if (updateDate.present) {
      map['update_date'] = Variable<String?>(updateDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (category.present) {
      final converter = $HealthcareProvidersTable.$converter0;
      map['category'] = Variable<String?>(converter.mapToSql(category.value));
    }
    if (street.present) {
      map['street'] = Variable<String?>(street.value);
    }
    if (specialization.present) {
      map['specialization'] = Variable<String?>(specialization.value);
    }
    if (houseNumber.present) {
      map['house_number'] = Variable<String?>(houseNumber.value);
    }
    if (city.present) {
      map['city'] = Variable<String?>(city.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String?>(postalCode.value);
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
          ..write('updateDate: $updateDate, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('street: $street, ')
          ..write('specialization: $specialization, ')
          ..write('houseNumber: $houseNumber, ')
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
  final VerificationMeta _updateDateMeta = const VerificationMeta('updateDate');
  late final GeneratedColumn<String?> updateDate = GeneratedColumn<String?>(
      'update_date', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumnWithTypeConverter<BuiltList<String>, String?>
      category = GeneratedColumn<String?>('category', aliasedName, true,
              typeName: 'TEXT', requiredDuringInsert: false)
          .withConverter<BuiltList<String>>(
              $HealthcareProvidersTable.$converter0);
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _specializationMeta =
      const VerificationMeta('specialization');
  late final GeneratedColumn<String?> specialization = GeneratedColumn<String?>(
      'specialization', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _houseNumberMeta =
      const VerificationMeta('houseNumber');
  late final GeneratedColumn<String?> houseNumber = GeneratedColumn<String?>(
      'house_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _postalCodeMeta = const VerificationMeta('postalCode');
  late final GeneratedColumn<String?> postalCode = GeneratedColumn<String?>(
      'postal_code', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
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
        updateDate,
        title,
        category,
        street,
        specialization,
        houseNumber,
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
    if (data.containsKey('update_date')) {
      context.handle(
          _updateDateMeta,
          updateDate.isAcceptableOrUnknown(
              data['update_date']!, _updateDateMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    context.handle(_categoryMeta, const VerificationResult.success());
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    }
    if (data.containsKey('specialization')) {
      context.handle(
          _specializationMeta,
          specialization.isAcceptableOrUnknown(
              data['specialization']!, _specializationMeta));
    }
    if (data.containsKey('house_number')) {
      context.handle(
          _houseNumberMeta,
          houseNumber.isAcceptableOrUnknown(
              data['house_number']!, _houseNumberMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
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
      const CategoryConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $HealthcareProvidersTable healthcareProviders =
      $HealthcareProvidersTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final HealthcareProvidersDao healthcareProvidersDao =
      HealthcareProvidersDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, healthcareProviders];
}
