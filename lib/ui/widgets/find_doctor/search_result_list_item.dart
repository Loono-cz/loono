import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/search_helpers.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/find_doctor/search_result_marker.svg', width: 24),
      title: searchQuery == null
          ? Text(searchResult.text, style: LoonoFonts.fontStyle)
          : Text.rich(
              TextSpan(
                children: getHighlightedSearchSpans(
                  searchResult: searchResult,
                  searchQuery: searchQuery!,
                ),
              ),
            ),
      minLeadingWidth: 0,
      dense: true,
      onTap: () async {
        final autoRouter = AutoRouter.of(context);
        final contextReader = context.read<MapStateService>();
        FocusManager.instance.primaryFocus?.unfocus(); // dismisses keyboard
        await _userRepository.addSearchHistoryItem(searchResult);
        contextReader
          ..setDoctorDetail(null)
          ..setSpecialization(null);
        await autoRouter.pop(searchResult);
      },
    );
  }
}
