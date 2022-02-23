import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

const double _defaultAvatarSize = 50.0;

class LoonoAvatar extends StatelessWidget {
  /// Loads user's avatar from the cache.
  ///
  /// If the user does not have an avatar yet, the [DefaultLoonoCircleAvatar] one will
  /// be loaded instead.
  LoonoAvatar({Key? key, this.radius = _defaultAvatarSize}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return LoonoAvatarWrapper(
      child: StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return user?.profileImageUrl == null
              ? DefaultLoonoCircleAvatar(radius: radius)
              : CachedNetworkImage(
                  imageUrl: user!.profileImageUrl!,
                  imageBuilder: (_, imageProvider) => CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.white,
                    foregroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: LoonoColors.primaryEnabled),
                  ),
                  errorWidget: (context, url, dynamic error) =>
                      DefaultLoonoCircleAvatar(radius: radius),
                );
        },
      ),
    );
  }
}

class CustomLoonoAvatar extends StatelessWidget {
  /// Loads a Loono styled [NetworkImage] avatar from the given [url].
  const CustomLoonoAvatar.network({
    Key? key,
    this.radius = _defaultAvatarSize,
    required this.url,
  })  : imageBytes = null,
        super(key: key);

  /// Loads a Loono styled [MemoryImage] avatar from the given [imageBytes].
  const CustomLoonoAvatar.memory({
    Key? key,
    this.radius = _defaultAvatarSize,
    required this.imageBytes,
  })  : url = null,
        super(key: key);

  final double radius;
  final Uint8List? imageBytes;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return LoonoAvatarWrapper(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        foregroundImage: imageBytes == null ? null : MemoryImage(imageBytes!),
        child: url == null
            ? null
            : ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  url!,
                  errorBuilder: (_, __, ___) => DefaultLoonoCircleAvatar(radius: radius),
                ),
              ),
      ),
    );
  }
}

class LoonoAvatarWrapper extends StatelessWidget {
  /// Wraps a widget with Loono styled border.
  const LoonoAvatarWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: LoonoColors.leaderboardPrimary,
      ),
      child: child,
    );
  }
}

class DefaultLoonoCircleAvatar extends StatelessWidget {
  const DefaultLoonoCircleAvatar({Key? key, required this.radius}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: SvgPicture.asset('assets/icons/default_avatar.svg', color: LoonoColors.primary),
    );
  }
}
