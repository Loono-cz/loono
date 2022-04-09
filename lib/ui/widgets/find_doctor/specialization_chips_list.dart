import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/specializations_list_sheet.dart';
import 'package:provider/provider.dart';

// key - spec name in chip in UI
// value - actual spec name in db
const defaultSpecs = <String, String>{
  'Praktický lékař': 'Praktik',
  'Zubař': 'Zubař',
  'Gynekolog': 'Gynekologie a porodnictví',
  'Dermatolog': 'Dermatovenerologie, kožní',
  'Oční': 'Oční',
  'Další odbornosti': '',
};

class SpecializationChipsList extends StatelessWidget {
  SpecializationChipsList({
    Key? key,
    this.showDefaultSpecs = true,
  })  : _specs = showDefaultSpecs ? defaultSpecs : Map.fromEntries([defaultSpecs.entries.last]),
        super(key: key);

  final bool showDefaultSpecs;
  final Map<String, String> _specs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 5,
          children: _specs.entries
              .mapIndexed(
                (i, e) => i == _specs.length - 1
                    ? ActionChip(
                        label: Text(
                          e.key,
                          style: LoonoFonts.fontStyle.copyWith(color: Colors.white),
                        ),
                        shape: const StadiumBorder(
                          side: BorderSide(color: LoonoColors.primaryEnabled),
                        ),
                        backgroundColor: LoonoColors.primaryEnabled,
                        shadowColor: Colors.transparent,
                        onPressed: () {
                          showSpecializationsListSheet(context);
                        },
                      )
                    : ActionChip(
                        label: Text(e.key, style: LoonoFonts.fontStyle),
                        shape: const StadiumBorder(
                          side: BorderSide(color: LoonoColors.primaryEnabled),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPressed: () {
                          final mapState = context.read<MapStateService>();
                          final specResult = mapState.getSpecSearchResultByName(e.value);
                          mapState.setSpecialization(specResult);
                        },
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
