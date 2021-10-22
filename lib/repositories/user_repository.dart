
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/achievement.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';
import 'package:uuid/uuid.dart';

// TODO: Connect with ApiService
class UserRepository {
  final _db = registry.get<DatabaseService>();

  Future<void> createUser() async {
    await _db.users.deleteAll();
    await _db.users.upsert(User(id: const Uuid().v4()));
  }

  Future<void> updateCurrentUser(UsersCompanion usersCompanion) async =>
      _db.users.updateCurrentUser(usersCompanion);

  Future<void> updateSex(Sex sex) async => _db.users.updateSex(sex);

  Future<void> updateDateOfBirth(DateWithoutDay dateWithoutDay) async =>
      _db.users.updateDateOfBirth(dateWithoutDay);

  Future<void> updateGeneralPracticionerCcaVisit(CcaDoctorVisit ccaDoctorVisit) async =>
      _db.users.updateGeneralPracticionerCcaVisit(ccaDoctorVisit);

  Future<void> updateGeneralPracticionerVisitDate(DateWithoutDay dateWithoutDay) async =>
      _db.users.updateGeneralPracticionerVisitDate(dateWithoutDay);

  Future<void> updateGynecologyCcaVisit(CcaDoctorVisit ccaDoctorVisit) async =>
      _db.users.updateGynecologyCcaVisit(ccaDoctorVisit);

  Future<void> updateGynecologyVisitDate(DateWithoutDay dateWithoutDay) async =>
      _db.users.updateGynecologyVisitDate(dateWithoutDay);

  Future<void> updateDentistCcaVisit(CcaDoctorVisit ccaDoctorVisit) async =>
      _db.users.updateDentistCcaVisit(ccaDoctorVisit);

  Future<void> updateDentistVisitDate(DateWithoutDay dateWithoutDay) async =>
      _db.users.updateDentistVisitDate(dateWithoutDay);

  Future<void> updateNickname(String nickname) async => _db.users.updateNickname(nickname);

  Future<void> updateEmail(String email) async => _db.users.updateEmail(email);

  Future<void> updateAchievementCollection(Achievement achievement) async =>
      _db.users.updateAchievementCollection(achievement);
}
