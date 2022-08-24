import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:permission_handler/permission_handler.dart';

class NoPermissionsScreen extends StatefulWidget {
  const NoPermissionsScreen({Key? key}) : super(key: key);

  @override
  State<NoPermissionsScreen> createState() => _NoPermissionsScreenState();
}

class _NoPermissionsScreenState extends State<NoPermissionsScreen> {
  bool allowInSettings = false;

  Future<void> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if ([LocationPermission.deniedForever].contains(permission)) {
      setState(() {
        allowInSettings = true;
      });
    }
  }

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        leading: IconButton(
          icon: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset('assets/icons/arrow_back.svg'),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AutoRouter.of(context).popAndPush(const DoctorSearchDetailRoute());
            },
            child: Text(
              context.l10n.location_permission_action,
              style: LoonoFonts.fontStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const Spacer(),
              Text(
                allowInSettings ? context.l10n.location_permission_title : '',
                style: LoonoFonts.fontStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(70),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/navigation.svg',
                    width: 63,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                context.l10n.location_permission_subtitle,
                style: LoonoFonts.fontStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LoonoButton(
                text: allowInSettings
                    ? context.l10n.calendar_permission_sheet_button
                    : context.l10n.allow_location,
                onTap: allowInSettings
                    ? openAppSettings
                    : () async {
                        final autoRouter = AutoRouter.of(context);
                        final permission = await Geolocator.requestPermission();

                        if ([LocationPermission.deniedForever].contains(permission)) {
                          setState(() {
                            allowInSettings = true;
                          });
                        } else {
                          await autoRouter.pop();
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
