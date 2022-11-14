import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/feedback/feedback_button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/registry.dart';

class PreventionHeader extends StatelessWidget {
  const PreventionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersDao = registry.get<DatabaseService>().users;
    const radius = 27.0;
    return Column(
      children: [
        StreamBuilder<User?>(
          stream: usersDao.watchUser(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return GestureDetector(
              onTap: () => showSettingsSheet(context),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoonoAvatar(
                            radius: radius,
                            borderWidth: 3,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //const FeedbackButton(),
                              const SizedBox(
                                height: 48,
                              ),
                              if (user?.points != null && user?.nickname != null)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        '${user?.nickname}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: LoonoFonts.headerFontStyle.copyWith(
                                          color: LoonoColors.grey,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const LoonoPointIcon(
                                          color: LoonoColors.primaryEnabled,
                                          width: 16.0,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          '${user?.points}',
                                          key: const Key('profileButton_points'),
                                          style: LoonoFonts.subtitleFontStyle.copyWith(
                                            color: LoonoColors.primaryEnabled,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: FeedbackButton(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
