import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class LoonoAvatar extends StatelessWidget {
  LoonoAvatar({Key? key, this.radius = 50.0, this.imageBytes}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  final Uint8List? imageBytes;
  final double radius;

  Widget get _defaultAvatar => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        foregroundImage: imageBytes == null ? null : MemoryImage(imageBytes!),
        child: SvgPicture.asset('assets/icons/default_avatar.svg', color: LoonoColors.primary),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: LoonoColors.leaderboardPrimary,
      ),
      child: imageBytes != null
          ? _defaultAvatar
          : StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                return user?.profileImageUrl == null
                    ? _defaultAvatar
                    : CachedNetworkImage(
                        imageUrl: user!.profileImageUrl!,
                        imageBuilder: (_, imageProvider) => CircleAvatar(
                          radius: radius,
                          backgroundColor: Colors.white,
                          foregroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => _defaultAvatar,
                        errorWidget: (context, url, error) => _defaultAvatar,
                      );
              },
            ),
    );
  }
}
