import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/genders_container.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/utils/registry.dart';

class EditSexScreen extends StatefulWidget {
  const EditSexScreen({Key? key}) : super(key: key);

  @override
  State<EditSexScreen> createState() => _EditSexScreenState();
}

class _EditSexScreenState extends State<EditSexScreen> {
  Sex? activeButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(
                child: GendersContainer(
                  genderCallBack: (gender) => setState(() => activeButton = gender),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LoonoButton(
                  text: context.l10n.action_save,
                  enabled: activeButton != null,
                  onTap: activeButton == null
                      ? () {}
                      : () async {
                          await registry.get<UserRepository>().updateSex(activeButton!);
                          AutoRouter.of(context).pop();
                        },
                ),
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
