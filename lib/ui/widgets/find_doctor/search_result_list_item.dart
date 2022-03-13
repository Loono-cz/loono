import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/text_highlighter.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class SearchResultListItem extends StatelessWidget {
  SearchResultListItem({
    Key? key,
    required this.searchResult,
    this.searchQuery,
  }) : super(key: key);

  final SearchResult searchResult;
  final String? searchQuery;

  final _userRepository = registry.get<UserRepository>();

  List<TextSpan> getStyle(String searchQuery) {
    return TextHighlighter.parse(
      searchResult.text,
      highlightPattern: searchQuery,
      isInputNormalized: true,
    )
        .map(
          (item) => TextSpan(
            text: item.text,
            style: item.highlight
                ? LoonoFonts.fontStyle.copyWith(fontWeight: FontWeight.bold)
                : LoonoFonts.fontStyle,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/find_doctor/search_result_marker.svg', width: 24),
      title: searchQuery == null
          ? Text(searchResult.text)
          : Text.rich(TextSpan(children: getStyle(searchQuery!))),
      minLeadingWidth: 0,
      dense: true,
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus(); // dismisses keyboard
        final healthcareProvider = searchResult.data;
        if (healthcareProvider != null) {
          await _userRepository.addSearchHistoryItem(healthcareProvider);
        }
        context.read<MapStateService>()
          ..setDoctorDetail(null)
          ..setSpecialization(null);
        await AutoRouter.of(context).pop(searchResult);
      },
    );
  }
}
