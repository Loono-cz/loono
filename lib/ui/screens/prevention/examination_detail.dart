import 'package:flutter/material.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            'Examination detail',
          ),
        ),
      ),
    );
  }
}
