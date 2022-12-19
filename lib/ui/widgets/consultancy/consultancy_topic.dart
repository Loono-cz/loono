import 'package:loono_api/loono_api.dart';

class ConsultancyTopic {
  const ConsultancyTopic(this.type, {this.examinationType, this.selfExaminationType});

  const ConsultancyTopic.examination({required ExaminationType examinationType})
      : this(
          ConsultancyTopicType.examination,
          examinationType: examinationType,
        );
  const ConsultancyTopic.selfExamination({required SelfExaminationType selfExaminationType})
      : this(
          ConsultancyTopicType.selfExamination,
          selfExaminationType: selfExaminationType,
        );

  final ConsultancyTopicType type;

  ///use when [type] is [ConsultancyTopicType.examination]
  final ExaminationType? examinationType;

  ///use when [type] is [ConsultancyTopicType.selfExamination]
  final SelfExaminationType? selfExaminationType;
}

enum ConsultancyTopicType {
  prevention,
  examination,
  selfExamination;
}
