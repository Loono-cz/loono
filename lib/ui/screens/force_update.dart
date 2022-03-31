import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:open_store/open_store.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Flexible(
                  child: SvgPicture.asset(
                    'assets/icons/update.svg',
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.force_update_title,
                      style: LoonoFonts.headerFontStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      context.l10n.force_update_subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                LoonoButton(
                  key: const Key('forceUpdatePage_btn_forceUpdate'),
                  text: context.l10n.force_update_button,
                  onTap: () {
                    OpenStore.instance.open(
                      appStoreId: '1573646003',
                      androidAppBundleId: 'cz.loono.app',
                    );
                  },
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
