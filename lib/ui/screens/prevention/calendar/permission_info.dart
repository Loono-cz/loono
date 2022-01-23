import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/calendar_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';

class CalendarPermissionInfoScreen extends StatelessWidget {
  const CalendarPermissionInfoScreen({
    Key? key,
    required this.examinationRecord,
  }) : super(key: key);

  final ExaminationRecord examinationRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => AutoRouter.of(context).pop(),
                  child: Text(
                    l10n.calendar_permission_close,
                    style: const TextStyle(color: LoonoColors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/prevention/calendar.svg',
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              const SizedBox(height: 40),
              Text(
                l10n.calendar_permission_desc,
                style: LoonoFonts.paragraphFontStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              LoonoButton(
                text: l10n.calendar_permission_allow_button,
                onTap: () async {
                  final permissionsGranted =
                      await registry.get<CalendarService>().promptPermissions();
                  if (permissionsGranted) {
                    await AutoRouter.of(context)
                        .popAndPush(CalendarListRoute(examinationRecord: examinationRecord));
                  } else {
                    // TODO: Navigate to guide screen on how to enable the permission
                    showSnackBarError(context, message: 'TODO: nepovolen přístup ke kalendáři');
                  }
                },
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
