import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:provider/provider.dart';

Future<void> showSpecializationsListSheet(BuildContext context) async {
  final mapState = context.read<MapStateService>();
  final allSpecializations = mapState.allSpecs
    ..sort((a, b) => (a.overriddenText ?? '').compareTo(b.overriddenText ?? ''));
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    backgroundColor: LoonoColors.bottomSheetPrevention,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 32),
                    onPressed: () => AutoRouter.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  context.l10n.find_doctor_spec_sheet_header,
                  style: LoonoFonts.headerFontStyle,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allSpecializations.length,
                  itemBuilder: (context, index) {
                    final spec = allSpecializations[index];
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: ActionChip(
                        label: Text(spec.overriddenText ?? '', style: LoonoFonts.fontStyle),
                        shape: const StadiumBorder(
                          side: BorderSide(color: LoonoColors.primaryEnabled),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPressed: () {
                          context
                              .read<MapStateService>()
                              .setSpecialization(allSpecializations[index]);
                          AutoRouter.of(context).pop();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
