import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class NewDateScreen extends StatefulWidget {
  const NewDateScreen({
    Key? key,
    required this.categorizedExamination,
    this.showCancelIcon = true,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final bool showCancelIcon;

  @override
  _NewDateScreenState createState() => _NewDateScreenState();
}

class _NewDateScreenState extends State<NewDateScreen> {
  DateTime? _newDate;

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  void onDateChanged(DateTime date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        _newDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final examinationType = widget.categorizedExamination.examination.examinationType;
    final preposition = czechPreposition(context, examinationType: examinationType);
    final title1 =
        '${_sex == Sex.MALE ? l10n.checkup_new_date_title_male : l10n.checkup_new_date_title_female} $preposition ';
    final cancelRoute =
        ExaminationDetailRoute(categorizedExamination: widget.categorizedExamination);
    return Scaffold(
      backgroundColor: LoonoColors.bottomSheetPrevention,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LoonoColors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
        actions: [
          if (widget.showCancelIcon)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => AutoRouter.of(context).popUntilRouteWithName(cancelRoute.routeName),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title1, style: LoonoFonts.headerFontStyle),
              Text(
                '${examinationTypeCasus(
                  context,
                  casus: Casus.genitiv,
                  examinationType: examinationType,
                ).toUpperCase()}?',
                style: LoonoFonts.headerFontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Center(
                child: CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: DateTime.now().year - 1900,
                  yearsOverActual: 2,
                  allowDays: true,
                ),
              ),
              const Spacer(),
              LoonoButton(
                text: context.l10n.continue_info,
                enabled: _newDate != null,
                onTap: () => AutoRouter.of(context).pop(),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
