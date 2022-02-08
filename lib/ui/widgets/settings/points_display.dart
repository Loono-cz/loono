import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/utils/registry.dart';

class PointsDisplay extends StatelessWidget {
  PointsDisplay({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

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
            // TODO: points
            return const Text(
              '0',
              style: LoonoFonts.primaryColorStyle,
            );
          },
        ),
      ],
    );
  }
}
