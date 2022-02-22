import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class BadgeComposer extends StatefulWidget {
  const BadgeComposer({Key? key}) : super(key: key);

  @override
  _BadgeComposerState createState() => _BadgeComposerState();
}

class _BadgeComposerState extends State<BadgeComposer> {
  final _usersDao = registry.get<DatabaseService>().users;

  Widget _getGoogles(Sex sex, int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/goggles-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getHeadband(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/headband/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getBoots(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/boots/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getBelt(Sex sex, int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/belt-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getArmour(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/armour-woman/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getCloak(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/cloak/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getCloakBuckle(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/cloak-buckle/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getGloves(Sex sex, int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/gloves-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getShield(int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/shield/level_$level.svg',
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final sex = snapshot.data?.sex ?? Sex.FEMALE;
                final badges = snapshot.data?.badges ?? BuiltList(<Badge>[]);

                int _levelOf(BadgeType type) {
                  return badges.firstWhereOrNull((e) => e.type == type)?.level ?? 0;
                }

                return SizedBox(
                  width: 180,
                  height: 300,
                  child: Stack(
                    key: ValueKey(sex),
                    children: [
                      _getCloak(_levelOf(BadgeType.COAT)),
                      SvgPicture.asset(
                        sex == Sex.MALE
                            ? 'assets/badges/body/man.svg'
                            : 'assets/badges/body/woman.svg',
                      ),
                      _getHeadband(_levelOf(BadgeType.HEADBAND)),
                      _getGoogles(sex, _levelOf(BadgeType.GLASSES)),
                      _getBoots(_levelOf(BadgeType.SHOES)),
                      if (sex == Sex.FEMALE) _getArmour(_levelOf(BadgeType.TOP)),
                      _getBelt(sex, _levelOf(BadgeType.BELT)),
                      _getCloakBuckle(_levelOf(BadgeType.COAT)),
                      _getGloves(sex, _levelOf(BadgeType.GLOVES)),
                      _getShield(_levelOf(BadgeType.SHIELD)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
