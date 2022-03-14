import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class BadgeComposer extends StatefulWidget {
  const BadgeComposer({
    Key? key,
    this.topPadding = 40,
  }) : super(key: key);

  final double topPadding;

  @override
  _BadgeComposerState createState() => _BadgeComposerState();
}

class _BadgeComposerState extends State<BadgeComposer> {
  final _usersDao = registry.get<DatabaseService>().users;

  static const supportedBadgeLevels = 5;

  Widget _getGoogles(Sex sex, int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/goggles-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
                ),
                Positioned(
                  top: 50,
                  left: (MediaQuery.of(context).size.width / 2) - 150,
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 110),
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          context.l10n.badge_googles_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/googles_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getHeadband(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/headband/level_$level.svg',
                ),
                Positioned(
                  top: 30,
                  left: (MediaQuery.of(context).size.width / 2) + 30,
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          context.l10n.badge_headband_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/headband_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getBoots(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/boots/level_$level.svg',
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 170,
                  top: 260,
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 130),
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          context.l10n.badge_boots_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/boots_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getBelt(Sex sex, int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/belt-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) + 40,
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 100),
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          sex == Sex.FEMALE
                              ? context.l10n.badge_belt_female_desc.toUpperCase()
                              : context.l10n.badge_belt_male_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/belt_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getArmour(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/armour-woman/level_$level.svg',
                ),
                Positioned(
                  top: 90,
                  left: (MediaQuery.of(context).size.width / 2) - 160,
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 130),
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          context.l10n.badge_buckle_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/buckle_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getCloak(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/cloak/level_$level.svg',
                ),
                Positioned(
                  top: 240,
                  left: (MediaQuery.of(context).size.width / 2) + 30,
                  child: Stack(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          context.l10n.badge_cloak_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/badges/lines/cloak_line.svg',
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getCloakBuckle(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              'assets/badges/cloak-buckle/level_$level.svg',
            ),
          )
        : const SizedBox();
  }

  Widget _getGloves(Sex sex, int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/gloves-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
                ),
                Positioned(
                  top: 180,
                  left: (MediaQuery.of(context).size.width / 2) + 40,
                  child: Stack(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        height: 35,
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          context.l10n.badge_gloves_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: SvgPicture.asset(
                          'assets/badges/lines/gloves_line.svg',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _getShield(int level) {
    return level > 0
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/badges/shield/level_$level.svg',
                ),
                Positioned(
                  top: 210,
                  left: (MediaQuery.of(context).size.width / 2) - 180,
                  child: Stack(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        height: 35,
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          context.l10n.badge_shield_desc.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: SvgPicture.asset(
                          'assets/badges/lines/shield_line.svg',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
            SizedBox(
              height: widget.topPadding,
            ),
            StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final sex = snapshot.data?.sex;
                final badges = snapshot.data?.badges ?? BuiltList(<Badge>[]);

                int _levelOf(BadgeType type) {
                  final level = badges.firstWhereOrNull((e) => e.type == type)?.level;
                  if (level != null && level > supportedBadgeLevels) {
                    debugPrint(
                      '⚠️ debug hint: app currently supports only $supportedBadgeLevels levels of badge assets ⚠️',
                    );
                  }
                  return level?.clamp(0, supportedBadgeLevels) ?? 0;
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: sex != null
                      ? Stack(
                          alignment: Alignment.center,
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
                        )
                      : const SizedBox(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
