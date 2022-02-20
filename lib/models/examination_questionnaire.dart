import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

part 'examination_questionnaire.g.dart';

class ExaminationQuestionnaires extends Table {
  @override
  Set<Column> get primaryKey => {type};

  TextColumn get type => text().map(const ExaminationTypeDbConverter())();

  TextColumn get status => text().map(const ExaminationStatusDbConverter()).withDefault(
        Constant(const ExaminationStatusDbConverter().mapToSql(ExaminationStatus.NEW)!),
      )();

  DateTimeColumn get date => dateTime().nullable()();

  BoolColumn get firstExam => boolean().nullable()();
}

@UseDao(tables: [ExaminationQuestionnaires])
class ExaminationQuestionnairesDao extends DatabaseAccessor<AppDatabase>
    with _$ExaminationQuestionnairesDaoMixin {
  ExaminationQuestionnairesDao(AppDatabase db) : super(db);

  Future<ExaminationQuestionnaire?> get(ExaminationType examinationType) =>
      (select(examinationQuestionnaires)
            ..where(
              (tbl) =>
                  tbl.type.equals(const ExaminationTypeDbConverter().mapToSql(examinationType)),
            ))
          .getSingleOrNull();

  Future<List<ExaminationQuestionnaire>> getAll() => select(examinationQuestionnaires).get();

  Stream<ExaminationQuestionnaire?> watch(ExaminationType examinationType) =>
      (select(examinationQuestionnaires)
            ..where(
              (tbl) =>
                  tbl.type.equals(const ExaminationTypeDbConverter().mapToSql(examinationType)),
            ))
          .watchSingleOrNull();

  Stream<List<ExaminationQuestionnaire>> watchAll() => select(examinationQuestionnaires).watch();

  Future<void> createQuestionnaire(ExaminationType examinationType) async {
    await into(examinationQuestionnaires).insert(
      ExaminationQuestionnairesCompanion.insert(type: examinationType),
      mode: InsertMode.replace,
    );
  }

  Future<void> updateCcaDoctorVisit(
    ExaminationType examinationType, {
    required CcaDoctorVisit ccaDoctorVisit,
  }) async {
    switch (ccaDoctorVisit) {
      case CcaDoctorVisit.inLastXYears:
        await updateQuestionnaire(
          examinationType,
          examinationQuestionnairesCompanion: const ExaminationQuestionnairesCompanion(
            status: Value<ExaminationStatus>(ExaminationStatus.CONFIRMED),
          ),
        );
        break;
      case CcaDoctorVisit.moreThanXYearsOrIdk:
        await updateQuestionnaire(
          examinationType,
          examinationQuestionnairesCompanion: const ExaminationQuestionnairesCompanion(
            status: Value<ExaminationStatus>(ExaminationStatus.UNKNOWN),
          ),
        );
        break;
    }
  }

  Future<void> updateLastVisitDate(
    ExaminationType examinationType, {
    required DateWithoutDay dateWithoutDay,
  }) async {
    await updateQuestionnaire(
      examinationType,
      examinationQuestionnairesCompanion: ExaminationQuestionnairesCompanion(
        date: Value<DateTime>(DateTime(dateWithoutDay.year, dateWithoutDay.month.index + 1)),
      ),
    );
  }

  Future<void> setDontKnowLastVisitDate(ExaminationType examinationType) async {
    await updateQuestionnaire(
      examinationType,
      examinationQuestionnairesCompanion: ExaminationQuestionnairesCompanion(
        date: Value<DateTime>(DateTime.now()),
      ),
    );
  }

  Future<void> updateQuestionnaire(
    ExaminationType examinationType, {
    required ExaminationQuestionnairesCompanion examinationQuestionnairesCompanion,
  }) async {
    await (update(examinationQuestionnaires)
          ..where(
            (tbl) => tbl.type.equals(const ExaminationTypeDbConverter().mapToSql(examinationType)),
          ))
        .write(examinationQuestionnairesCompanion);
  }
}
