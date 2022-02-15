import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
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

  @override
  void initState() {
    super.initState();

    registry.get<ApiService>().getLeaderboard().then((e) {
      e.map(
        success: (leaderboard) {
          setState(() {
            _leaderboardData = leaderboard.data;
            _fetchState = FetchState.loaded;
          });
        },
        failure: (e) {
          setState(() => _fetchState = FetchState.error);
          showSnackBarError(context, message: context.l10n.something_went_wrong);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
            _getLeaderboardList(),
            const SizedBox(height: 20.0),
            LoonoButton.light(
              text: context.l10n.leaderboard_points_help_button,
              onTap: () => widget.changePage(SettingsPage.points),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getLeaderboardList() {
    switch (_fetchState) {
      case FetchState.loading:
        return const CircularProgressIndicator();
      case FetchState.error:
        return const SizedBox.shrink();
      case FetchState.loaded:
        return Flexible(
          child: ListView(
            children: [
              ..._leaderboardData!.top.asMap().entries.map(
                    (e) => LeaderboardTile(
                      position: e.key,
                      user: e.value,
                    ),
                  ),
              Divider(
                color: LoonoColors.leaderboardPrimary,
                indent: MediaQuery.of(context).size.width / 4,
                endIndent: MediaQuery.of(context).size.width / 4,
              ),
              ..._leaderboardData!.peers.asMap().entries.map(
                    (e) => LeaderboardTile(
                      position: e.key,
                      user: e.value,
                    ),
                  ),
            ],
          ),
        );
    }
  }
}
