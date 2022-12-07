import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:loono/helpers/categorized_examination_converter.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class NotificationRouter {
  NotificationRouter(this.screen, [this.uuid = '']);

  factory NotificationRouter.fromNotificationData(Map<String, dynamic>? data) {
    if (data == null) {
      return NotificationRouter(NotificationScreen.main);
    }
    var screen = NotificationScreen.main;
    switch (data[screenParamName]) {
      case 'checkup':
        screen = NotificationScreen.examination;
        break;
      case 'self':
        screen = NotificationScreen.selfExamination;
        break;
      default:
        screen = NotificationScreen.main;
    }
    return NotificationRouter(screen, data[uuidParamName].toString());
  }

  static const screenParamName = 'screen';
  static const uuidParamName = 'examinationUuid';

  final NotificationScreen screen;
  final String uuid;

  bool loaded = false;

  final List<Function> _onDone = [];

  AppRouter get appRouter => registry.get<AppRouter>();

  Future<void> navigate() async {
   appRouter.push(MainRoute(notificationRouter:this)).ignore();
    log(screen.toString());
    if (screen.isExamination) {
      var exams = <ExaminationPreventionStatus>[];
      var selfExams = <SelfExaminationPreventionStatus>[];
      final examsResponse = await registry.get<ApiService>().getExaminations();

      examsResponse.map(
        success: (data) {
          exams = data.data.examinations.toList();
          selfExams = data.data.selfexaminations.toList();
        },
        failure: (err) {
          log('Unable to fetch examination data for notifications');
        },
      );
      switch (screen) {
        case NotificationScreen.examination:
          await _openExaminationScreen(exams, uuid);
          break;
        case NotificationScreen.selfExamination:
          await _openSelfExaminationScreen(selfExams, uuid);
          break;
        default:
          return;
      }
    }
  }

  Future<void> _openExaminationScreen(List<ExaminationPreventionStatus> exams, String uuid) async {
    final categorized = CategorizedExaminationConverter.convert(
      exams.where((exam) => exam.uuid == uuid).toList(),
    );
    log('open push notification on $categorized');
    if (categorized.length == 1) {
      _notifyListeners();
      await appRouter.push(
        ExaminationDetailRoute(
          categorizedExamination: categorized.first,
        ),
      );
    } else {
      _notifyListeners();
      log('examination with uuid $uuid was not found');
    }
  }

  Future<void> _openSelfExaminationScreen(
    List<SelfExaminationPreventionStatus> selfExams,
    String uuid,
  ) async {
    final selfExam = selfExams.firstWhereOrNull((element) => element.lastExamUuid == uuid);
    if (selfExam != null) {
      final account = await registry.get<ApiService>().getAccount();
      var sex = Sex.MALE;
      account.map(
        success: (data) {
          sex = data.data.sex;
        },
        failure: (err) {
          log('Unable to fetch examination data for notifications');
        },
      );
      _notifyListeners();
      await appRouter.push(
        SelfExaminationDetailRoute(
          sex: sex,
          selfExamination: selfExam,
        ),
      );
    } else {
      _notifyListeners();
      log('self examination with uuid $uuid was not found');
    }
  }

  void _notifyListeners() {
    for (final listener in _onDone) {
      listener.call();
    }
  }

  void addListener(Function listener) {
    if (loaded) {
      listener.call();
    } else {
      _onDone.add(listener);
    }
  }
}

enum NotificationScreen {
  main,
  examination,
  selfExamination;

  bool get isExamination => this == examination || this == selfExamination;
}
