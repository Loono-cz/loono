import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_action_types.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_input_text_field.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class CustomExamFormScreen extends StatefulWidget {
  const CustomExamFormScreen({Key? key}) : super(key: key);

  @override
  State<CustomExamFormScreen> createState() => _CustomExamFormScreenState();
}

class _CustomExamFormScreenState extends State<CustomExamFormScreen> {
  ExaminationType? _specialist;
  ExaminationActionType? _examinationType;
  bool _isPeriodicExam = false;

  String _customInterval = '';
  String _note = '';
  DateTime? _periodDateTime;
  DateTime? _lastExamDate;
  DateTime? _nextExamDate;

  bool _lastExamChck = false;
  bool _nextExamChck = false;
  bool _showError = false;
  bool _showLastExamError = false;
  bool _showPeriodDateTimeError = false;
  @override
  void initState() {
    super.initState();
  }

  final _usersDao = registry.get<DatabaseService>().users;

  String _getUserLabelBySex(BuildContext context, {required Sex? sex}) {
    if (sex == null) return '';
    late final String value;
    switch (sex) {
      case Sex.MALE:
        value = context.l10n.wich_date_you_have_reservation_male;
        break;
      case Sex.FEMALE:
        value = context.l10n.wich_date_you_have_reservation_female;
        break;
    }
    return value;
  }

  void onProviderSet(ExaminationType? provider) => setState(() {
        _specialist = provider;
        _showError = false;
      });

  void onActionTypeSet(ExaminationActionType? examination) => setState(() {
        _examinationType = examination;
        _showError = false;
      });

  void onDateSet(DateTime? dateTime) => setState(() {
        _periodDateTime = dateTime;
        _showPeriodDateTimeError = false;
      });

  void onLastExamDateSet(DateTime? dateTime) => setState(() {
        _lastExamDate = dateTime;
        _showError = false;
      });
  void onNextExamDateSet(DateTime? dateTime) => setState(() {
        _nextExamDate = dateTime;
      });

  void setLastExamCheckbox(bool value) => setState(() {
        _lastExamChck = value;
        _showLastExamError = false;
      });
  void setNextExamCheckbox(bool value) => setState(() {
        _nextExamChck = value;
      });

  void setFrequencyExam(String value) => setState(() {
        _customInterval = value;
        _showLastExamError = false;
      });
  void onNoteChange(String value) => setState(() {
        _note = value;
      });

  BuildContext? providerContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            AutoRouter.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.add_examination,
                style: LoonoFonts.customExamLabel,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputTextField(
                error: _showError,
                label: _specialist == null ? '' : context.l10n.specialist,
                hintText: context.l10n.choose_specialist,
                value: _specialist != null ? ExaminationTypeExt(_specialist!).l10n_name : '',
                onClickInputField: () => AutoRouter.of(context).navigate(
                  ChooseSpecialistRoute(
                    specialist: _specialist,
                    onProviderSet: onProviderSet,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputTextField(
                error: _specialist != null && _examinationType == null || _showError,
                label: _specialist == null ? '' : context.l10n.examination_type,
                hintText: context.l10n.choose_examination_type,
                value: _examinationType != null
                    ? ExaminationActionTypeExt(_examinationType!).l10n_name
                    : '',
                onClickInputField: () => AutoRouter.of(context).navigate(
                  ChooseCustomExaminationTypeRoute(
                    actionType: _examinationType,
                    onActionTypeSet: onActionTypeSet,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(context.l10n.exam_frequency),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: LoonoColors.primary, width: 1),
                ),
                child: Row(
                  children: [
                    checkboxConetnt(
                      context,
                      context.l10n.disposable, //TODO: Translation
                      () => setState(() {
                        _isPeriodicExam = false;
                        _showPeriodDateTimeError = false;
                        _showLastExamError = false;
                      }),
                      !_isPeriodicExam,
                      false,
                    ),
                    checkboxConetnt(
                      context,
                      context.l10n.regularly, //TODO: Translation
                      () => setState(() {
                        _isPeriodicExam = true;
                        _showPeriodDateTimeError = false;
                        _showLastExamError = false;
                      }),
                      _isPeriodicExam,
                      true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(child: buildFrequentionForm(context)),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                minLines: 5,
                maxLines: 10,
                maxLength: 256,
                keyboardType: TextInputType.multiline,
                initialValue: _note,
                enabled: _isPeriodicExam ? _nextExamDate != null : true,
                onChanged: onNoteChange,
                decoration: InputDecoration(
                  hintText: context.l10n.note_visiting_description,
                  label: Text(context.l10n.note_visiting),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: LoonoButton(
                  text: context.l10n.action_save,
                  onTap: () async {
                    if (_specialist != null && _examinationType != null) {
                      if (_isPeriodicExam) {
                        if (_lastExamDate != null && _nextExamDate != null) {
                          await sendMandatoryRequest();
                        } else if (_lastExamDate != null) {
                          await sendMandatoryRequestConfirm();
                        } else {
                          await sendRegularlyRequestNew();
                        }
                      } else {
                        await sendOnceRequest();
                      }
                    } else {
                      setState(() {
                        _showError = true;
                        if (!_isPeriodicExam) {
                          _showPeriodDateTimeError = true;
                        } else {
                          _showLastExamError = true;
                        }
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget checkboxConetnt(
    BuildContext context,
    String text,
    VoidCallback onCheck,
    bool checkValue,
    bool borderLeft,
  ) {
    const borderSide = BorderSide(color: LoonoColors.primary);
    return Expanded(
      child: InkWell(
        onTap: onCheck,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: checkValue && borderLeft ? borderSide : BorderSide.none,
              right: checkValue && !borderLeft ? borderSide : BorderSide.none,
            ),
            color: checkValue ? LoonoColors.primaryLight : null,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                checkValue ? Icons.check : null,
                color: LoonoColors.primaryEnabled,
              ),
              Text(
                text,
                style: TextStyle(
                  color: checkValue ? LoonoColors.primaryEnabled : Colors.black,
                  fontSize: 14.0,
                  fontWeight: checkValue ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFrequentionForm(BuildContext context) {
    if (_isPeriodicExam) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(context.l10n.once_to),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 2,
                child: CustomInputTextField(
                  error: _showError,
                  label: '',
                  hintText: context.l10n.exam_frequency,
                  value: _customInterval,
                  onClickInputField: () => AutoRouter.of(context).navigate(
                    ChooseFrequencyOfExamRoute(
                      value: _customInterval,
                      valueChanged: setFrequencyExam,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: LoonoSizes.isScreenSmall(context)
                    ? MediaQuery.of(context).size.width * 0.55
                    : MediaQuery.of(context).size.width * 0.6,
                child: CustomInputTextField(
                  error: _showLastExamError,
                  enabled: !_lastExamChck,
                  label: _lastExamDate == null ? '' : context.l10n.last_examination,
                  hintText: context.l10n.last_examination,
                  value: _lastExamDate != null
                      ? DateFormat(LoonoStrings.dateFormat).format(_lastExamDate!)
                      : '',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    width: 5,
                    height: 5,
                    fit: BoxFit.scaleDown,
                    color: _lastExamChck ? Colors.black38 : Colors.black87,
                  ),
                  onClickInputField: () => AutoRouter.of(context).navigate(
                    ChooseExamPeriodDateRoute(
                      pickTime: false,
                      label: context.l10n.your_last_examination,
                      dateTime: _lastExamDate,
                      onValueChange: onLastExamDateSet,
                      isLastExamChoose: true,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: CheckboxCustom(
                  text: context.l10n.idk,
                  isChecked: _lastExamChck,
                  whatIsChecked: setLastExamCheckbox,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: LoonoSizes.isScreenSmall(context)
                    ? MediaQuery.of(context).size.width * 0.55
                    : MediaQuery.of(context).size.width * 0.6,
                child: CustomInputTextField(
                  error: false,
                  enabled: !_nextExamChck,
                  label: _nextExamDate == null ? '' : context.l10n.next_examination,
                  hintText: context.l10n.next_examination,
                  value: _nextExamDate != null
                      ? DateFormat(LoonoStrings.dateWithHoursFormat).format(_nextExamDate!)
                      : '',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    width: 5,
                    height: 5,
                    fit: BoxFit.scaleDown,
                    color: _nextExamChck ? Colors.black38 : Colors.black87,
                  ),
                  onClickInputField: () => AutoRouter.of(context).navigate(
                    ChooseExamPeriodDateRoute(
                      showLastExamDate: true,
                      label: _getUserLabelBySex(context, sex: _usersDao.user?.sex ?? Sex.FEMALE),
                      pickTime: true,
                      dateTime: _nextExamDate,
                      onValueChange: onNextExamDateSet,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: CheckboxCustom(
                  text: context.l10n.for_now_idk,
                  isChecked: _nextExamChck,
                  whatIsChecked: setNextExamCheckbox,
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return SizedBox(
        width: (MediaQuery.of(context).size.width) - (MediaQuery.of(context).size.width / 20) * 10,
        child: CustomInputTextField(
          error: _showPeriodDateTimeError,
          label: _periodDateTime == null ? '' : context.l10n.examination_term,
          hintText: context.l10n.examination_term,
          value: _periodDateTime != null
              ? DateFormat(LoonoStrings.dateWithHoursFormat).format(_periodDateTime!)
              : '',
          prefixIcon: SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 5,
            height: 5,
            fit: BoxFit.scaleDown,
            color: Colors.black87,
          ),
          onClickInputField: () => AutoRouter.of(context).navigate(
            ChooseExamPeriodDateRoute(
              label: _getUserLabelBySex(context, sex: _usersDao.user?.sex ?? Sex.FEMALE),
              pickTime: true,
              dateTime: _periodDateTime ?? DateTime.now(),
              onValueChange: onDateSet,
            ),
          ),
        ),
      );
    }
  }

  Future<void> sendRegularlyRequestNew() async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          _specialist!,
          actionType: _examinationType,
          periodicExam: _isPeriodicExam,
          note: _note,
          customInterval: transformInterval(_customInterval), // Pravidelne
          newDate: _lastExamChck && _nextExamChck ? DateTime.now() : _nextExamDate,
          categoryType: ExaminationCategoryType.CUSTOM,
          status:
              _lastExamChck && _nextExamChck ? ExaminationStatus.UNKNOWN : ExaminationStatus.NEW,
          firstExam: true,
        );

    response.map(
      success: (res) {
        Provider.of<ExaminationsProvider>(context, listen: false).createCustomExamination(res.data);
        AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
        showFlushBarSuccess(context, context.l10n.examinatoin_was_added);
      },
      failure: (err) => showFlushBarError(
        context,
        statusCodeToText(
          context,
          err.error.response?.statusCode,
        ),
      ),
    );
  }

  Future<void> sendMandatoryRequestConfirm() async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          _specialist!,
          actionType: _examinationType,
          periodicExam: _isPeriodicExam,
          note: _note,
          customInterval: transformInterval(_customInterval), // Pravidelne
          newDate: _lastExamDate,
          categoryType: ExaminationCategoryType.CUSTOM,
          status: ExaminationStatus.CONFIRMED,
          firstExam: true,
        );

    response.map(
      success: (res) {
        Provider.of<ExaminationsProvider>(context, listen: false)
            .createCustomExamination(res.data, lastConfirmedDate: _lastExamDate);
        AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
        showFlushBarSuccess(context, context.l10n.examinatoin_was_added);
      },
      failure: (err) => showFlushBarError(
        context,
        statusCodeToText(
          context,
          err.error.response?.statusCode,
        ),
      ),
    );
  }

  Future<void> sendMandatoryRequest() async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          _specialist!,
          actionType: _examinationType,
          periodicExam: _isPeriodicExam,
          note: _note,
          customInterval: transformInterval(_customInterval), // Pravidelne
          newDate: _lastExamDate,
          categoryType: ExaminationCategoryType.CUSTOM,
          status: ExaminationStatus.CONFIRMED,
          firstExam: true,
        );
    response.map(
      success: (res) {
        registry
            .get<ExaminationRepository>()
            .postExamination(
              _specialist!,
              actionType: _examinationType,
              periodicExam: _isPeriodicExam,
              note: _note,
              customInterval: transformInterval(_customInterval), // Pravidelne
              newDate: _nextExamDate,
              categoryType: ExaminationCategoryType.CUSTOM,
              status: ExaminationStatus.NEW,
              firstExam: false,
            )
            .then((value) {
          value.map(
            success: (newRes) {
              Provider.of<ExaminationsProvider>(context, listen: false)
                  .createCustomExamination(newRes.data, lastConfirmedDate: _lastExamDate);
              AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
              showFlushBarSuccess(context, context.l10n.examinatoin_was_added);
            },
            failure: (err) => showFlushBarError(
              context,
              statusCodeToText(
                context,
                err.error.response?.statusCode,
              ),
            ),
          );
        });
      },
      failure: (err) {
        showFlushBarError(
          context,
          statusCodeToText(
            context,
            err.error.response?.statusCode,
          ),
        );
      },
    );
  }

  Future<void> sendOnceRequest() async {
    final response = await registry.get<ExaminationRepository>().postExamination(
          _specialist!,
          actionType: _examinationType,
          periodicExam: _isPeriodicExam,
          note: _note,
          customInterval: null,
          newDate: _periodDateTime,
          categoryType: ExaminationCategoryType.CUSTOM,
          status: ExaminationStatus.NEW,
          firstExam: true,
        );
    response.map(
      success: (res) {
        Provider.of<ExaminationsProvider>(context, listen: false).createCustomExamination(res.data);
        AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
        showFlushBarSuccess(context, context.l10n.examinatoin_was_added);
      },
      failure: (err) {
        showFlushBarError(
          context,
          statusCodeToText(
            context,
            err.error.response?.statusCode,
          ),
        );
      },
    );
  }

  int transformInterval(String str) {
    final splitedString = str.split(' ');
    final number = splitedString[0];
    final desc = splitedString[1];
    return desc == context.l10n.years ? transformYearToMonth(number) : int.parse(number);
  }
}
