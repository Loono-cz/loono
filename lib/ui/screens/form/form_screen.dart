import 'package:flutter/material.dart';

import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/space.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 248, 253, 1),
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        context.l10n.specialist_question,
                        style: LoonoFonts.customExamLabel,
                      ),
                      const CustomSpacer.vertical(30),
                      const Text(
                        'Na tvé dotazy ohledně prevence a zdraví odpoví naši odborníci. Odpověd dostaneš cca do týdne na tvůj e-mail “user e-mail address”.',
                        style: LoonoFonts.paragraphFontStyle,
                      ),
                      const Divider(
                        height: 60,
                      ),
                      const Text('Jaké oblasti se dotaz týká?',
                          style: LoonoFonts.cardExaminaitonType,),
                      Container(),
                      const CustomSpacer.vertical(30),
                      
                      //TODO: Vyuzit existujuci
                      TextField(
                        controller: _textFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Prostor pro tvůj dotaz',
                        ),
                        maxLength: 700,
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        onSubmitted: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 70,
                left: 18,
                right: 18,
              ),
              child: LoonoButton(
                onTap: () {},
                text: 'Odeslat dotaz',
              ),
            )
          ],
        ),
      ),
    );
  }
}
