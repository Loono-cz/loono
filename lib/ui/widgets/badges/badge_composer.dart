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

  bool showControls = false;

  Widget _getGoogles() {
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
            SizedBox(
              width: 180,
              height: 300,
              child: Stack(
                key: ValueKey(sex),
                children: [
                  if (showCloak) _getCloak(),
                  SvgPicture.asset(
                    sex == Sex.MALE ? 'assets/badges/body/man.svg' : 'assets/badges/body/woman.svg',
                  ),
                  if (showHeadband) _getHeadband(),
                  if (showGoogles) _getGoogles(),
                  if (showBoots) _getBoots(),
                  if (sex == Sex.FEMALE && showArmour) _getArmour(),
                  if (showBelt) _getBelt(),
                  if (showCloak) _getCloakBuckle(),
                  if (showGloves) _getGloves(),
                  if (showShield) _getShield(),
                ],
              ),
            ),
            Row(
              children: [
                const Text('controls'),
                Switch(
                  value: showControls,
                  onChanged: (value) {
                    setState(() {
                      showControls = value;
                    });
                  },
                ),
              ],
            ),
            if (showControls)
              Column(
                children: [
                  Row(
                    children: [
                      Switch(
                        value: sex == Sex.FEMALE,
                        onChanged: (value) {
                          setState(() {
                            sex = value ? Sex.FEMALE : Sex.MALE;
                          });
                        },
                      ),
                      Slider(
                        value: level.toDouble(),
                        max: 5,
                        divisions: 5,
                        label: level.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            level = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: showGoogles,
                        onChanged: (value) {
                          setState(() {
                            showGoogles = value;
                          });
                        },
                      ),
                      const Text('Goggles'),
                      Switch(
                        value: showArmour,
                        onChanged: (value) {
                          setState(() {
                            showArmour = value;
                          });
                        },
                      ),
                      const Text('Armour')
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: showHeadband,
                        onChanged: (value) {
                          setState(() {
                            showHeadband = value;
                          });
                        },
                      ),
                      const Text('Headband'),
                      Switch(
                        value: showBelt,
                        onChanged: (value) {
                          setState(() {
                            showBelt = value;
                          });
                        },
                      ),
                      const Text('Belt')
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: showBoots,
                        onChanged: (value) {
                          setState(() {
                            showBoots = value;
                          });
                        },
                      ),
                      const Text('Boots'),
                      Switch(
                        value: showCloak,
                        onChanged: (value) {
                          setState(() {
                            showCloak = value;
                          });
                        },
                      ),
                      const Text('Cloak'),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: showGloves,
                        onChanged: (value) {
                          setState(() {
                            showGloves = value;
                          });
                        },
                      ),
                      const Text('Gloves'),
                      Switch(
                        value: showShield,
                        onChanged: (value) {
                          setState(() {
                            showShield = value;
                          });
                        },
                      ),
                      const Text('Shield'),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
