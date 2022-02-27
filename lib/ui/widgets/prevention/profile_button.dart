import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/registry.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usersDao = registry.get<DatabaseService>().users;
    const radius = 27.0;
    return Column(
      children: [
        StreamBuilder<User?>(
          stream: _usersDao.watchUser(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return GestureDetector(
              onTap: () => showSettingsSheet(context),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 3,
                          color: LoonoColors.primary,
                        ),
                      ),
                      child: user?.profileImageUrl == null
                          ? const DefaultLoonoCircleAvatar(radius: radius)
                          : CachedNetworkImage(
                              imageUrl: user!.profileImageUrl!,
                              imageBuilder: (_, imageProvider) => CircleAvatar(
                                radius: radius,
                                backgroundColor: Colors.white,
                                foregroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  height: radius * 2,
                                  width: radius * 2,
                                  child:
                                      CircularProgressIndicator(color: LoonoColors.primaryEnabled),
                                ),
                              ),
                              errorWidget: (context, url, dynamic error) =>
                                  const DefaultLoonoCircleAvatar(radius: radius),
                            ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    if (user?.points != null && user?.nickname != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user?.nickname}',
                            style: LoonoFonts.headerFontStyle.copyWith(
                              color: LoonoColors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              const LoonoPointIcon(color: LoonoColors.primaryEnabled, width: 16.0),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                '${user?.points}',
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
              ),
            );
          },
        ),
      ],
    );
  }
}
