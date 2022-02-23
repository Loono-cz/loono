import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono_api/loono_api.dart';

class BadgeComposer extends StatefulWidget {
  const BadgeComposer({Key? key}) : super(key: key);

  @override
  _BadgeComposerState createState() => _BadgeComposerState();
}

class _BadgeComposerState extends State<BadgeComposer> {
  Sex sex = Sex.FEMALE;
  int level = 0;
  bool showGoogles = true;
  bool showArmour = true;
  bool showHeadband = true;
  bool showBoots = true;
  bool showBelt = true;
  bool showCloak = true;
  bool showGloves = true;
  bool showShield = true;

  static const supportedBadgeLevels = 5;

  Widget _getGoogles(Sex sex, int level) {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/goggles-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getHeadband() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/headband/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getBoots() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/boots/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getBelt() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/belt-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getArmour() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/armour-woman/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getCloak() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/cloak/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getCloakBuckle() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/cloak-buckle/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getGloves() {
    return level > 0
        ? SvgPicture.asset(
            'assets/badges/gloves-${sex == Sex.MALE ? 'man' : 'woman'}/level_$level.svg',
          )
        : const SizedBox();
  }

  Widget _getShield() {
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
                  width: 180,
                  height: 300,
                  child: sex != null
                      ? Stack(
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
