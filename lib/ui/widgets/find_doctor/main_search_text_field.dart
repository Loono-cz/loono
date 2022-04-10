import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/search_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/search_text_field_icon.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final ValueChanged<SearchResult>? onItemTap;

  @override
  Widget build(BuildContext context) {
    const iconWidth = 24.0;
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
    final specialization =
        context.select<MapStateService, SearchResult?>((value) => value.currSpecialization);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: () async {
          final result = await AutoRouter.of(context).push(const DoctorSearchDetailRoute());
          if (result != null && result is SearchResult) {
            onItemTap?.call(result);
          }
        },
        autofocus: false,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          border: customSearchInputDecoration(
            color: LoonoColors.primaryEnabled,
            inputBorder: inputBorder,
          ),
          fillColor: Colors.white,
          filled: true,
          iconColor: LoonoColors.primaryEnabled,
          focusColor: LoonoColors.primaryEnabled,
          focusedBorder: customSearchInputDecoration(
            color: LoonoColors.primaryEnabled,
            inputBorder: inputBorder,
          ),
          enabledBorder: customSearchInputDecoration(
            color: LoonoColors.primaryEnabled,
            inputBorder: inputBorder,
          ),
          hintText: specialization == null
              ? context.l10n.find_doctor_search_hint
              : specialization.overriddenText ?? '',
          hintStyle: specialization == null
              ? LoonoFonts.fontStyle.copyWith(color: LoonoColors.grey)
              : LoonoFonts.fontStyle,
          suffixIconConstraints: const BoxConstraints(
            minWidth: iconWidth,
            minHeight: iconWidth,
            maxHeight: iconWidth,
            maxWidth: iconWidth + 10,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: iconWidth,
            minHeight: iconWidth,
            maxHeight: iconWidth,
            maxWidth: iconWidth + 10,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(bottom: 3, left: 10),
            child: SearchTextFieldIcon(),
          ),
          suffixIcon: specialization == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () => context.read<MapStateService>().setSpecialization(null),
                  child: const SearchTextFieldIcon(
                    assetPath: 'assets/icons/find_doctor/search_clear.svg',
                    iconWidth: iconWidth,
                  ),
                ),
        ),
      ),
    );
  }
}
