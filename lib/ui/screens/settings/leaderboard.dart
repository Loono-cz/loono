import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/settings/leaderboard_tile.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

enum FetchState { loading, loaded, error }

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({
    Key? key,
    required this.changePage,
  }) : super(key: key);

  final Function(SettingsPage) changePage;

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  FetchState _fetchState = FetchState.loading;
  Leaderboard? _leaderboardData;

  List<LeaderboardUser> _peers = [];

  @override
  void initState() {
    super.initState();

    registry.get<ApiService>().getLeaderboard().then((e) {
      e.map(
        success: (leaderboard) {
          _processData(leaderboard);
        },
        failure: (e) {
          setState(() => _fetchState = FetchState.error);
          showFlushBarError(context, context.l10n.something_went_wrong);
        },
      );
    });
  }

  Future<void> _processData(SuccessApiResponse<Leaderboard> leaderboard) async {
    final userRepository = registry.get<UserRepository>();
    final user = await userRepository.getCurrentUser();

    _leaderboardData = leaderboard.data;
    _peers = _leaderboardData!.peers.toList();
    if (user != null) {
      await _peers.insertMe(user, _leaderboardData!.myOrder);
    }
    setState(() {
      _fetchState = FetchState.loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_leaderboardData == null && _fetchState == FetchState.loaded) {
      setState(() => _fetchState = FetchState.error);
      showFlushBarError(context, context.l10n.something_went_wrong);
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.leaderboard,
                  style: const TextStyle(fontSize: 24),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: LoonoPointIcon(color: LoonoColors.primary, width: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(child: _getLeaderboardList()),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _getLeaderboardList() {
    switch (_fetchState) {
      case FetchState.loading:
        return const Center(child: CircularProgressIndicator(color: LoonoColors.primaryEnabled));
      case FetchState.error:
        return const SizedBox.shrink();
      case FetchState.loaded:
        return ListView(
          children: [
            ..._leaderboardData!.top.asMap().entries.map(
                  (e) => LeaderboardTile(
                    position: e.key + 1,
                    user: e.value,
                  ),
                ),
            if (!_leaderboardData!.top.toList().containsMe()) ..._getPeersPart()
          ],
        );
    }
  }

  List<Widget> _getPeersPart() {
    return [
      Divider(
        color: LoonoColors.leaderboardPrimary,
        indent: MediaQuery.of(context).size.width / 4,
        endIndent: MediaQuery.of(context).size.width / 4,
      ),
      ..._peers.asMap().entries.mapIndexed(
            (i, e) => LeaderboardTile(
              position: e.value.isThisMe == true
                  ? _leaderboardData!.myOrder
                  : (i == 0 ? _leaderboardData!.myOrder - 1 : _leaderboardData!.myOrder + 1),
              user: e.value,
            ),
          ),
    ];
  }
}

extension _LeaderboardUserListExt on List<LeaderboardUser> {
  bool containsMe() {
    for (final user in this) {
      if (user.isThisMe == true) return true;
    }
    return false;
  }

  Future<void> insertMe(User currentUser, int myOrder) async {
    if (containsMe()) return;

    final builder = LeaderboardUserBuilder()
      ..isThisMe = true
      ..points = currentUser.points
      ..profileImageUrl = currentUser.profileImageUrl
      ..name = currentUser.nickname;
    insert(1, builder.build());
  }
}
