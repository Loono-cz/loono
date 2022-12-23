import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:loono/ui/widgets/form/form_content.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({
    super.key,
    this.initializedType = QuestionTypes.selfExam,
  });

  final QuestionTypes initializedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
      body: SafeArea(
        child: FormContent(initializedType),
      ),
    );
  }
}
