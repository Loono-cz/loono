import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart' as api;

class PreventionScreen extends StatefulWidget {
  const PreventionScreen({Key? key}) : super(key: key);

  @override
  State<PreventionScreen> createState() => _PreventionScreenState();
}

class _PreventionScreenState extends State<PreventionScreen> {
  final _apiService = registry.get<ApiService>();
  final _usersDao = registry.get<DatabaseService>().users;

  Future<void> _sync() async {
    // TODO: there is no /sync API endpoint, so at least fetch user account settings
    final account = await _apiService.getAccount();
    await account.whenOrNull(
      success: (data) async {
        // TODO: updating db fields one by one is not very ideal, should be done in one transaction
        await _usersDao.updateNickname(data.user.nickname);
        if (data.user.birthdateYear != null && data.user.birthdateMonth != null) {
          await _usersDao.updateDateOfBirth(
            DateWithoutDay(
              month: monthFromInt(data.user.birthdateMonth!),
              year: data.user.birthdateYear!,
            ),
          );
        }
        if (data.user.sex != null) {
          await _usersDao.updateSex(data.user.sex == api.Sex.MALE ? Sex.male : Sex.female);
        }
        if (data.user.preferredEmail != null) {
          await _usersDao.updateEmail(data.user.preferredEmail!);
        }
        if (data.user.profileImageUrl != null) {
          await _usersDao.updateProfileImageUrl(data.user.profileImageUrl!);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // TODO: this is not very ideal approach but at least something
    // checks if db account info is empty, if yes, then the user has just logged in
    // with an existing account
    if (_usersDao.user != null && _usersDao.user!.email == null) {
      debugPrint('log: SYNCING WITH API');
      _sync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // TODO: Only user with created account can open Settings
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () => AutoRouter.of(context).push(OpenSettingsRoute()),
                child: const Text('SETTINGS'),
              ),
            ),
            ExaminationsSheetOverlay(),
          ],
        ),
      ),
    );
  }
}
