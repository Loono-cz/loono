// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono_api/loono_api.dart';

void main() {
  /* group('ExaminationRecord status calculation', () {
    var now = DateTime(2021, 12, 4);

    group('scheduledSoonOrOverdue', () {
      final examinations = <ExaminationRecordTemp>[
        ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.GENERAL_PRACTITIONER,
          worth: 200,
          interval: 2,
          priority: 1,
          nextVisitDate: DateTime(2021, 12, 28, 11),
          firstExam: false,
        ),
        ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.GYNECOLOGIST,
          worth: 300,
          interval: 1,
          priority: 3,
          nextVisitDate: DateTime(2021, 12, 12, 10),
          firstExam: false,
        ),
      ];

      test('calculates the status correctly - examinations within 30 days window', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationCategory>[
          ExaminationCategory.scheduledSoonOrOverdue(),
          ExaminationCategory.scheduledSoonOrOverdue(),
        ]);
      });

      test('calculates correctly overdue examination', () {
        final overdueExamination = ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.DENTIST,
          worth: 300,
          interval: 1,
          priority: 8,
          nextVisitDate: DateTime(2021, 10, 4, 7),
          firstExam: false,
        );

        final status = overdueExamination.calculateStatus(now);
        expect(status, ExaminationCategory.scheduledSoonOrOverdue());
      });
    });

    group('unknownLastVisit', () {
      final examinations = <ExaminationRecordTemp>[
        const ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.OPHTHALMOLOGIST,
          worth: 100,
          interval: 2,
          priority: 9,
          firstExam: false,
        ),
        const ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.COLONOSCOPY,
          worth: 1000,
          interval: 10,
          priority: 4,
          firstExam: false,
        ),
      ];

      test('calculates the status correctly - unknown last visit date', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationCategory>[
          ExaminationCategory.unknownLastVisit(),
          ExaminationCategory.unknownLastVisit(),
        ]);
      });
    });

    group('scheduled', () {
      final examination = ExaminationRecordTemp(
        examinationType: ExaminationTypeEnum.DERMATOLOGIST,
        worth: 200,
        interval: 1,
        priority: 6,
        nextVisitDate: DateTime(2022, 3, 10, 13),
        firstExam: false,
      );

      test('calculates the status correctly - examinations are more than 30 days from now', () {
        final status = examination.calculateStatus(now);
        expect(status, ExaminationCategory.scheduled());
      });
    });

    group('waiting', () {
      final examination = ExaminationRecordTemp(
        examinationType: ExaminationTypeEnum.UROLOGIST,
        worth: 500,
        interval: 2,
        priority: 2,
        lastVisitDate: DateWithoutDay(month: Months.september, year: 2021),
        firstExam: false,
      );

      final examinations = <ExaminationRecordTemp>[
        examination,
        ExaminationRecordTemp(
          examinationType: ExaminationTypeEnum.MAMMOGRAM,
          worth: 500,
          interval: 2,
          priority: 3,
          lastVisitDate: DateWithoutDay(month: Months.march, year: 2021),
          firstExam: false,
        ),
      ];

      test('calculates the status correctly - still waiting', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationCategory>[
          ExaminationCategory.waiting(),
          ExaminationCategory.waiting(),
        ]);
      });

      test('calculates the status correctly - not waiting anymore', () {
        now = DateTime(examination.lastVisitDate!.year, examination.lastVisitDate!.month.index + 1);

        // exact interval
        var newDate = DateTime(now.year + examination.interval, now.month);
        var status = examination.calculateStatus(newDate);
        expect(status, ExaminationCategory.newToSchedule());

        // also after the interval
        newDate =
            DateTime(now.year + examination.interval, now.month + TO_SCHEDULE_MONTHS_TRANSFER);
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationCategory.newToSchedule());

        // also 2 months before exact interval
        newDate =
            DateTime(now.year + examination.interval, now.month - TO_SCHEDULE_MONTHS_TRANSFER);
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationCategory.newToSchedule());

        // but not 3 months before exact interval
        newDate = DateTime(
          now.year + examination.interval,
          now.month - (TO_SCHEDULE_MONTHS_TRANSFER + 1),
        );
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationCategory.waiting());
      });
    });
  });*/
}
