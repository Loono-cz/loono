import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/specializations_list_sheet.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

// key - spec name in chip in UI
// value - actual spec name from API
const _defaultSpecs = <String, String>{
  'Praktický lékař': 'Praktický lékař',
  'Zubař': 'Zubař',
  'Gynekolog': 'Gynekologie a porodnictví',
  'Dermatolog': 'Dermatovenerologie, kožní',
  'Oční': 'Oční',
  'Další odbornosti': '',
};

String getSpecializationByExaminationType(ExaminationType examinationType) {
  switch (examinationType) {
    case ExaminationType.GENERAL_PRACTITIONER:
      return _defaultSpecs['Praktický lékař'] ?? '';
    case ExaminationType.DENTIST:
      return _defaultSpecs['Zubař'] ?? '';
    case ExaminationType.GYNECOLOGIST:
      return _defaultSpecs['Gynekolog'] ?? '';
    case ExaminationType.DERMATOLOGIST:
      return _defaultSpecs['Dermatolog'] ?? '';
    case ExaminationType.OPHTHALMOLOGIST:
      return _defaultSpecs['Oční'] ?? '';
    default:
      return _defaultSpecs['Další odbornosti'] ?? '';
  }
}

class SpecializationChipsList extends StatelessWidget {
  SpecializationChipsList({
    Key? key,
    this.showDefaultSpecs = true,
  })  : _specs = showDefaultSpecs ? _defaultSpecs : Map.fromEntries([_defaultSpecs.entries.last]),
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
