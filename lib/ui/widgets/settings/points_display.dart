import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/models/user.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/utils/registry.dart';

class PointsDisplay extends StatelessWidget {
  PointsDisplay({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  int _calculateTotalPoints(User? user) {
    if (user == null) return 0;

    var points = 0;
    for (final examinationType in ExaminationType.values) {
      switch (examinationType) {
        case ExaminationType.GENERAL_PRACTITIONER:
          points += _getAwardPoints(
            examinationType: examinationType,
            ccaDoctorVisit: user.generalPracticionerCcaVisit,
          );
          break;
        case ExaminationType.GYNECOLOGIST:
          points += _getAwardPoints(
            examinationType: examinationType,
            ccaDoctorVisit: user.gynecologyCcaVisit,
          );
          break;
        case ExaminationType.DENTIST:
          points += _getAwardPoints(
            examinationType: examinationType,
            ccaDoctorVisit: user.dentistCcaVisit,
          );
          break;
        // TODO: Add the rest of ExaminationTypes once are added
        default:
          break;
      }
    }
    return points;
  }

  int _getAwardPoints({
    required ExaminationType examinationType,
    required CcaDoctorVisit? ccaDoctorVisit,
  }) {
    return ccaDoctorVisit == CcaDoctorVisit.inLastTwoYears ? examinationType.awardPoints : 0;
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
              _calculateTotalPoints(snapshot.data).toString(),
              style: LoonoFonts.primaryColorStyle,
            );
          },
        ),
      ],
    );
  }
}
