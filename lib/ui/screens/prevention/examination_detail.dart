import 'package:flutter/material.dart';
import 'package:loono/models/categorized_examination.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            'Examination detail:\n${categorizedExamination.toString()}',
          ),
        ),
      ),
    );
  }
}
