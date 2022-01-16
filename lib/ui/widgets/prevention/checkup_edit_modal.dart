import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';

void showEditModal(BuildContext pageContext, CategorizedExamination examination) {
  final examinationType = examination.examination.examinationType;
  final preposition = czechPreposition(pageContext, examinationType: examinationType);
  final procedure =
      procedureQuestionTitle(pageContext, examinationType: examinationType).toLowerCase();

  showCupertinoModalPopup<void>(
    context: pageContext,
    builder: (BuildContext modalContext) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            AutoRouter.of(modalContext).pop();
            AutoRouter.of(pageContext).navigate(
              CancelCheckupRoute(
                title: '${pageContext.l10n.checkup_cancel_question} $preposition $procedure?',
                date: examination.examination.nextVisitDate ?? DateTime.now(),
              ),
            );
          },
          child: Text(pageContext.l10n.cancel_checkup),
        ),
        CupertinoActionSheetAction(
          child: Text(
            pageContext.l10n.edit_checkup,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            AutoRouter.of(modalContext).pop();
          },
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            AutoRouter.of(modalContext).pop();
          },
          child: Text(
            pageContext.l10n.back,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    ),
  );
}
