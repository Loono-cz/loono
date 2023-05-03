import 'package:collection/collection.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/categorized_examination_converter.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class NotificationRouter {
  NotificationRouter(this.screen, [this.uuid = '']);

  factory NotificationRouter.fromNotificationData(Map<String, dynamic> data) {
    if (data.isEmpty) {
      return NotificationRouter(NotificationScreen.main);
    }
    var screen = NotificationScreen.main;
    switch (data[LoonoStrings.notificationScreenParamName]) {
      case LoonoStrings.notificationScreenExamination:
        screen = NotificationScreen.examination;
        break;
      case LoonoStrings.notificationScreenSelfExamination:
        screen = NotificationScreen.selfExamination;
        break;
      default:
        screen = NotificationScreen.main;
    }
    return NotificationRouter(screen, data[LoonoStrings.notificationUuidParamName].toString());
  }

  AppRouter get appRouter => registry.get<AppRouter>();

  final NotificationScreen screen;
  final String uuid;

  bool loaded = false;

  Future<void> navigate() async {
    if (screen.isExamination) {
      await appRouter.pushAll(const [NotificationLoadingRoute()]);
      var exams = <ExaminationPreventionStatus>[];
      var selfExams = <SelfExaminationPreventionStatus>[];
      final examsResponse = await registry.get<ApiService>().getExaminations();

      examsResponse.map(
        success: (data) {
          exams = data.data.examinations.toList();
          selfExams = data.data.selfexaminations.toList();
        },
        failure: (err) {},
      );
      switch (screen) {
        case NotificationScreen.examination:
          await _openExaminationScreen(exams, uuid);
          break;
        case NotificationScreen.selfExamination:
          appRouter.push(const MainRoute()).ignore();
          break;
        default:
          return;
      }
    }
  }

  Future<void> _openExaminationScreen(
    List<ExaminationPreventionStatus> exams,
    String uuid,
  ) async {
    final categorized = CategorizedExaminationConverter.convert(
      exams.where((exam) => exam.uuid == uuid).toList(),
    );
    if (categorized.isNotEmpty) {
      await appRouter.replace(
        ExaminationDetailRoute(
          categorizedExamination: categorized.first,
        ),
      );
    } else {
      appRouter.push(const MainRoute()).ignore();
    }
  }
}

enum NotificationScreen {
  main,
  examination,
  selfExamination;

  bool get isExamination => this == examination || this == selfExamination;
}
