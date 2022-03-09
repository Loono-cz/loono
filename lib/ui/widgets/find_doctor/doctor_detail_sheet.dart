import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';
import 'package:loono_api/loono_api.dart';

Future<void> showDoctorDetailSheet({
  required BuildContext context,
  required SimpleHealthcareProvider doctor,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    barrierColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (doctor.specialization != null)
                  Expanded(
                    child: Text(
                      '${doctor.specialization?.toUpperCase()}',
                      style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.close, size: 37),
                  onPressed: () => AutoRouter.of(context).pop(),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    doctor.title,
                    style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.secondaryFont),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    '${doctor.street ?? ""} ${doctor.houseNumber}\n${doctor.city}, ${doctor.postalCode}',
                    style: const TextStyle(color: LoonoColors.grey, height: 1.6),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _ActionButton(
              text: 'TODO: missing phone',
              iconPath: 'assets/icons/prevention/phone.svg',
              action: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            _ActionButton(
              text: 'TODO: missing email',
              iconPath: 'assets/icons/prevention/email.svg',
              action: () {},
            ),
          ],
        ),
      );
    },
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key, required this.text, required this.iconPath, required this.action})
      : super(key: key);

  final String text;
  final String iconPath;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      onTap: action,
      splashColor: null,
      materialColor: LoonoColors.buttonLight,
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 65.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                iconPath,
                width: 26,
                color: LoonoColors.primaryEnabled,
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
