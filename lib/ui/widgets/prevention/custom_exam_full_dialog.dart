import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';

void showCustomExamFullDialog({
  required BuildContext context,
  required AppRouter router,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 18),
          decoration: const BoxDecoration(
            color: LoonoColors.bottomSheetLight,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/custom_exam_full.svg',
                width: 60,
                height: 60,
              ),
              const SizedBox(
                height: 55,
              ),
              Text(
                context.l10n.custom_exam_full_dialog_title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                context.l10n.custom_exam_full_dialog_desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 26,
              ),
              LoonoButton(
                text: context.l10n.i_agree,
                onTap: () {
                  router.pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
