import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/search_helpers.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/search_result_list_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class SearchResultsList extends StatelessWidget {
  SearchResultsList({
    Key? key,
    required this.searchResults,
    required this.searchQueryText,
  })  : _specializationSearchResults = searchResults.where(isSpecialization),
        super(key: key);

  final List<SearchResult> searchResults;
  final String? searchQueryText;
  final Iterable<SearchResult> _specializationSearchResults;

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final searchResult = searchResults.elementAt(index);
        if (index == 0 && isSpecialization(searchResult)) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
            child: Wrap(
              spacing: 4,
              children: _specializationSearchResults
                  .map(
                    (specialization) => ActionChip(
                      label: searchQueryText == null
                          ? Text(specialization.text, style: LoonoFonts.fontStyle)
                          : Text.rich(
                              TextSpan(
                                children: getHighlightedSearchSpans(
                                  searchResult: specialization,
                                  searchQuery: searchQueryText!,
                                ),
                              ),
                            ),
                      shape: const StadiumBorder(
                        side: BorderSide(color: LoonoColors.primaryEnabled),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPressed: () async {
                        await _userRepository.addSearchHistoryItem(specialization);
                        context.read<MapStateService>().setSpecialization(specialization);
                        await AutoRouter.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        }
        if (!isSpecialization(searchResult)) {
          return SearchResultListItem(
            searchResult: searchResult,
            searchQuery: searchQueryText,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
