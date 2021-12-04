// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';

void main() {
  group('ExaminationRecord status calculation', () {
    var now = DateTime(2021, 12, 4);

    group('scheduledSoonOrOverdue', () {
      final examinations = <ExaminationRecord>[
        ExaminationRecord(
            examinationType: ExaminationType.GENERAL_PRACTITIONER,
            worth: 200,
            interval: 2,
            priority: 1,
            nextVisitDate: DateTime(2021, 12, 28, 11)),
        ExaminationRecord(
            examinationType: ExaminationType.GYNECOLOGIST,
            worth: 300,
            interval: 1,
            priority: 3,
            nextVisitDate: DateTime(2021, 12, 12, 10)),
      ];

      test('calculates the status correctly - examinations within 30 days window', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationStatus>[
          ExaminationStatus.scheduledSoonOrOverdue(),
          ExaminationStatus.scheduledSoonOrOverdue(),
        ]);
      });

      test('calculates correctly overdue examination', () {
        final overdueExamination = ExaminationRecord(
            examinationType: ExaminationType.DENTIST,
            worth: 300,
            interval: 1,
            priority: 8,
            nextVisitDate: DateTime(2021, 10, 4, 7));

        final status = overdueExamination.calculateStatus(now);
        expect(status, ExaminationStatus.scheduledSoonOrOverdue());
      });
    });

    group('unknownLastVisit', () {
      final examinations = <ExaminationRecord>[
        const ExaminationRecord(
            examinationType: ExaminationType.OPHTHALMOLOGIST, worth: 100, interval: 2, priority: 9),
        const ExaminationRecord(
            examinationType: ExaminationType.COLONOSCOPY, worth: 1000, interval: 10, priority: 4),
      ];

      test('calculates the status correctly - unknown last visit date', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationStatus>[
          ExaminationStatus.unknownLastVisit(),
          ExaminationStatus.unknownLastVisit(),
        ]);
      });
    });

    group('scheduled', () {
      final examination = ExaminationRecord(
          examinationType: ExaminationType.DERMATOLOGIST,
          worth: 200,
          interval: 1,
          priority: 6,
          nextVisitDate: DateTime(2022, 3, 10, 13));

      test('calculates the status correctly - examinations are more than 30 days from now', () {
        final status = examination.calculateStatus(now);
        expect(status, ExaminationStatus.scheduled());
      });
    });

    group('waiting', () {
      final examination = ExaminationRecord(
          examinationType: ExaminationType.UROLOGIST,
          worth: 500,
          interval: 2,
          priority: 2,
          lastVisitDate: DateWithoutDay(month: Months.september, year: 2021));

      final examinations = <ExaminationRecord>[
        examination,
        ExaminationRecord(
            examinationType: ExaminationType.MAMMOGRAM,
            worth: 500,
            interval: 2,
            priority: 3,
            lastVisitDate: DateWithoutDay(month: Months.march, year: 2021)),
      ];

      test('calculates the status correctly - still waiting', () {
        final statuses = examinations.map((e) => e.calculateStatus(now));
        expect(statuses, <ExaminationStatus>[
          ExaminationStatus.waiting(),
          ExaminationStatus.waiting(),
        ]);
      });

      test('calculates the status correctly - not waiting anymore', () {
        now = DateTime(examination.lastVisitDate!.year, examination.lastVisitDate!.month.index + 1);

        // exact interval
        var newDate = DateTime(now.year + examination.interval, now.month);
        var status = examination.calculateStatus(newDate);
        expect(status, ExaminationStatus.newToSchedule());

        // also after the interval
        newDate =
            DateTime(now.year + examination.interval, now.month + TO_SCHEDULE_MONTHS_TRANSFER);
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationStatus.newToSchedule());

        // also 2 months before exact interval
        newDate =
            DateTime(now.year + examination.interval, now.month - TO_SCHEDULE_MONTHS_TRANSFER);
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationStatus.newToSchedule());

        // but not 3 months before exact interval
        newDate = DateTime(
            now.year + examination.interval, now.month - (TO_SCHEDULE_MONTHS_TRANSFER + 1));
        status = examination.calculateStatus(newDate);
        expect(status, ExaminationStatus.waiting());
      });
    });
  });
}
