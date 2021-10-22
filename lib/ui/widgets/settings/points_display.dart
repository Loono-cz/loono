import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/utils/registry.dart';

class PointsDisplay extends StatelessWidget {
  PointsDisplay({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  int _calculatePoints(User? user) {
    if (user == null) return 0;
    var points = 0;
    for (final examinationType in ExaminationType.values) {
      switch (examinationType) {
        case ExaminationType.GENERAL_PRACTITIONER:
          final shouldAward = user.generalPracticionerCcaVisit == CcaDoctorVisit.inLastTwoYears;
          points += shouldAward ? GeneralPracticionerAchievementScreen.worth : 0;
          break;
        case ExaminationType.GYNECOLOGIST:
          final shouldAward = user.gynecologyCcaVisit == CcaDoctorVisit.inLastTwoYears;
          points += shouldAward ? GynecologyAchievementScreen.worth : 0;
          break;
        case ExaminationType.DENTIST:
          final shouldAward = user.dentistCcaVisit == CcaDoctorVisit.inLastTwoYears;
          points += shouldAward ? DentistAchievementScreen.worth : 0;
          break;
        default:
          break;
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LoonoPointIcon(width: 36.0),
        const SizedBox(width: 16.0),
        StreamBuilder<User?>(
          stream: _usersDao.watchUser(),
          builder: (context, snapshot) {
            return Text(
              _calculatePoints(snapshot.data).toString(),
              style: LoonoFonts.headerFontStyle.copyWith(color: LoonoColors.leaderboardPrimary),
            );
          },
        ),
      ],
    );
  }
}
